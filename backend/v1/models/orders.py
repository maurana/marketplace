from django.db import models

class Orders(models.Model):
    orders_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=True, verbose_name='ORDERS_ID')
    customer_name = models.CharField(max_length=250)
    customer_email = models.CharField(max_length=250)
    total_item = models.IntegerField(db_default=0)
    total_price = models.FloatField(db_default=0.00)
    orders_date = models.DateField(null=True, blank=True)

    class Meta:
        ordering = ['-orders_id']