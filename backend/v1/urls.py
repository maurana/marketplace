from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns

from v1.controllers.categories import *
from v1.controllers.products import *
from v1.controllers.orders import *
from v1.controllers.order_items import *
 
urlpatterns = [
    path('categories', CategoriesList.as_view()),
    path('categories/<int:pk>', CategoriesDetail.as_view()),
    path('products', ProductsList.as_view()),
    path('products/<int:pk>', ProductsDetail.as_view()),
    path('orders', OrdersList.as_view()),
    path('order_items', Order_ItemsList.as_view())
]

urlpatterns = format_suffix_patterns(urlpatterns)