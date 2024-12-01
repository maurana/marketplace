from django.test import TestCase
from django.test import Client
from django.urls import reverse

class Testing(TestCase):
    def test_index_page_loads_ok(self):
        print("api_service v1")