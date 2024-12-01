from django.http import Http404
from django.core.paginator import Paginator
from django.db.models import Q, OuterRef, Subquery
from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status

from v1.models.products import Products
from v1.models.categories import Categories
from v1.serializers.products import ProductsSerializer

class ProductsList(APIView):

    def get_queryset(self):
        keywords = self.request.query_params.get('keywords', None)
        categories = self.request.query_params.get('categories', None)

        base_qs = Products.objects.values(
            'products_name',
            'products_price', 
            'products_stock', 
            'products_image',
            'categories_id').annotate(
                categories_name=Subquery(
                Categories.objects.filter(
                    categories_id=OuterRef('categories_id'))
                    .order_by('categories_id')
                    .values('categories_name')[:1])).filter(
                        Q(products_name__icontains=keywords) and 
                        Q(categories_name__icontains=categories))
    
        return base_qs

    def get(self, request, format=None):
        queryset = self.get_queryset()
        pg = Paginator(queryset, request.GET.get('rows'), allow_empty_first_page=True)
        page_number = request.GET.get('page')
        page_obj = pg.page(page_number)

        response = {
            'params': {
                'keywords': request.GET.get('keywords'), 
                'categories': request.GET.get('categories')
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
                'rows': list(page_obj.object_list),
            }
            
        }

        return Response(response)

    def post(self, request, format=None):
        serializer = ProductsSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response({'message': 'Create successfully !'}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ProductsDetail(APIView):

    def get_object(self, pk):
        try:
            return Products.objects.get(pk=pk)
        except Products.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        products = self.get_object(pk)
        serializer = ProductsSerializer(products)
        return Response({'message': 'Show successfully !', 'data': serializer.data})

    def put(self, request, pk, format=None):
        products = self.get_object(pk)
        serializer = ProductsSerializer(products, data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response({'message': 'Update successfully !'})
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk, format=None):
        products = self.get_object(pk)
        products.delete()
        return Response({'message': 'Delete successfully !'}, status=status.HTTP_204_NO_CONTENT)