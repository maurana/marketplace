import os
from django.db import models
from django.dispatch import receiver
from django.core.files.storage import FileSystemStorage

from v1.models.categories import Categories
from v1.utils.filesave import *

default_storage = FileSystemStorage()

class Products(models.Model):
    products_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=True, verbose_name='PRODUCTS_ID')
    categories = models.ForeignKey(Categories, related_name='categories', on_delete=models.CASCADE)
    products_name = models.CharField(max_length=250)
    products_price = models.FloatField(db_default=0.00)
    products_stock = models.IntegerField(db_default=0)
    products_desc = models.TextField(null=True, blank=True)
    products_image = models.ImageField(upload_to=filesave,storage=default_storage)

    def __str__(self):
        return self.products_name

    class Meta:
        ordering = ['-products_id']

@receiver(models.signals.post_delete, sender=Products)
def auto_delete_file_on_delete(sender, instance, *args, **kwargs):
    if instance.products_image:
        if os.path.isfile(instance.products_image.path):
            os.remove(instance.products_image.path)

@receiver(models.signals.pre_save, sender=Products)
def auto_delete_file_on_change(sender, instance, *args, **kwargs):
    if not instance.pk:
        return False

    try:
        old_file = Products.objects.get(pk=instance.pk).products_image
    except Products.DoesNotExist:
        return False

    new_file = instance.products_image
    if not old_file == new_file:
        if os.path.isfile(old_file.path):
            os.remove(old_file.path)