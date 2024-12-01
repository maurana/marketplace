from django.db import models

class Categories(models.Model):
    categories_id = models.BigAutoField(auto_created=True, primary_key=True, serialize=True, verbose_name='CATEGORIES_ID')
    categories_name = models.CharField(max_length=250)

    class Meta:
        ordering = ['-categories_id']