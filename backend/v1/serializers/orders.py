from rest_framework import serializers
from v1.models.orders import Orders

class OrdersSerializer(serializers.ModelSerializer):
    class Meta:
        model = Orders
        fields = ['orders_id', 'customer_name', 'customer_email']