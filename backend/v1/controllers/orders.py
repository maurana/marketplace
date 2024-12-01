from datetime import date
from django.http import Http404
from django.db import transaction
from django.core.paginator import Paginator
from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status

from v1.models.products import Products
from v1.models.orders import Orders
from v1.models.order_items import Order_Items
from v1.serializers.products import ProductsSerializer
from v1.serializers.orders import OrdersSerializer
from v1.serializers.order_items import Order_ItemsSerializer

class OrdersList(APIView):

    def get(self, request, format=None):
        queryset = Orders.objects.filter(customer_name__contains=request.GET.get('keywords')).values()
        pg = Paginator(queryset, request.GET.get('rows'), allow_empty_first_page=True)
        page_number = request.GET.get('page')
        page_obj = pg.page(page_number)
        response = {
            'params': {
                'keywords': request.GET.get('keywords')
            },
            'message': 'List successfully !',
            'data': {
                'links': {
                    'start': page_obj.start_index(),
                    'next': page_obj.end_index(),
                },
                'total_data': page_obj.paginator.count,
                'total_page': page_obj.paginator.num_pages,
                'has_next': page_obj.has_next(),
                'has_previous': page_obj.has_previous(),
                'page': page_obj.number,
                'rows': list(page_obj.object_list)
            }
        }

        return Response(response)

    @transaction.non_atomic_requests
    def post(self, request, format=None):
        orderitem = request.data['order_items']
        faileditem, totalitem = 0, len(orderitem)
        orderserializer = OrdersSerializer(data=request.data)

        with transaction.atomic():
            if orderserializer.is_valid(raise_exception=True):
                orderserializer.save()

                for i in range(totalitem):
                    products = Products.objects.get(pk=orderitem[i]['products'])
                    productserializer = ProductsSerializer(products)
                    orderitem[i]['orders'] = orderserializer.data['orders_id']
                    orderitem[i]['item_price'] = productserializer.data['products_price']

                    if orderitem[i]['item_stock'] > productserializer.data['products_stock']:
                        faileditem += 1
                        orderitem[i]['status'] = 'Failed because not enough stock !'
                    else:
                        orderitem[i]['status'] = 'Succesfully !'
                        orderitemserializer = Order_ItemsSerializer(data=orderitem[i])
                        newstock = productserializer.data['products_stock'] - orderitem[i]['item_stock']

                        if orderitemserializer.is_valid(raise_exception=True):
                            orderitemserializer.save()
                            products.products_stock = int(newstock)
                            products.save()

                oi = Order_Items.objects.filter(orders=orderserializer.data["orders_id"]).values()
                totalprice = sum(map(float, [x * y for x, y in zip(oi.values_list('item_price', flat=True), oi.values_list('item_stock', flat=True))]))


                orders = Orders.objects.get(pk=orderserializer.data["orders_id"])
                orders.total_item = int(totalitem - faileditem)
                orders.total_price = totalprice
                orders.orders_date = date.today()
                orders.save()

                response = {
                    "message": [
                        {
                          "total_items": int(totalitem),
                          "total_sucess": int(totalitem - faileditem),
                          "total_falied": int(faileditem)
                        }
                    ],
                    "data": [
                        {
                            "orders_id": orders.orders_id,
                            "orders_date": orders.orders_date,
                            "customer_name": orders.customer_name,
                            "customer_email": orders.customer_email,
                            "total_item": orders.total_item,
                            "total_price": orders.total_price,
                            "order_items": orderitem
                        }
                    ]
                }

                return Response(response)
        return Response(orderserializer.errors, status=status.HTTP_400_BAD_REQUEST)