from django_filters import rest_framework as filters
from v1.models.products import Products

class ProductsFilter(filters.FilterSet):
    products_name = filters.CharFilter()
    categories = filters.NumberFilter()

    class Meta:
        model = Products
        fields = ['products_name','categories']