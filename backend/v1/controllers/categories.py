from django.http import Http404
from rest_framework.parsers import JSONParser
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status

from v1.models.categories import Categories
from v1.serializers.categories import CategoriesSerializer

class CategoriesList(APIView):

    def get(self, request, format=None):
        categories = Categories.objects.all()
        serializer = CategoriesSerializer(categories, many=True)
        return Response({'message': 'List successfully !', 'data': serializer.data})

    def post(self, request, format=None):
        serializer = CategoriesSerializer(data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response({'message': 'Create successfully !'}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class CategoriesDetail(APIView):

    def get_object(self, pk):
        try:
            return Categories.objects.get(pk=pk)
        except Categories.DoesNotExist:
            raise Http404

    def get(self, request, pk, format=None):
        categories = self.get_object(pk)
        serializer = CategoriesSerializer(categories)
        return Response({'message': 'Show successfully !', 'data': serializer.data})

    def put(self, request, pk, format=None):
        categories = self.get_object(pk)
        serializer = CategoriesSerializer(categories, data=request.data)
        if serializer.is_valid(raise_exception=True):
            serializer.save()
            return Response({'message': 'Update successfully !'})
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, pk, format=None):
        categories = self.get_object(pk)
        categories.delete()
        return Response({'message': 'Delete successfully !'}, status=status.HTTP_204_NO_CONTENT)