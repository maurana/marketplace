from rest_framework import serializers
from v1.models.order_items import Order_Items

class Order_ItemsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order_Items
        fields = '__all__'