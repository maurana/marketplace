from django.db import models

from v1.models.orders import Orders
from v1.models.products import Products

class Order_Items(models.Model):
    item_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=True, verbose_name='ITEM_ID')
    orders = models.ForeignKey(Orders, related_name='orders', on_delete=models.CASCADE)
    products = models.ForeignKey(Products, related_name='products', on_delete=models.CASCADE)
    item_price = models.FloatField(db_default=0.00)
    item_stock = models.IntegerField(db_default=0)
    
    class Meta:
        ordering = ['-item_id']