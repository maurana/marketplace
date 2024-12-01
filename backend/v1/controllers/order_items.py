from django.http import Http404
from django.db.models import Q, OuterRef, Subquery
from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status

from v1.models.order_items import Order_Items
from v1.serializers.order_items import Order_ItemsSerializer

class Order_ItemsList(APIView):

    # list all by order
    def get(self, request, format=None):
        result, order_id = [], request.GET.get('orders')
        queryset = Order_Items.objects.select_related('products').filter(orders=order_id)
        
        for dt in queryset:
            products_name = dt.products.products_name
            result.append({ 'item_id': dt.item_id, 'item_price': dt.item_price, 'item_stock': dt.item_stock,'products_name': products_name,})

        return Response({'message': 'List successfully !', 'data': list(result)})
