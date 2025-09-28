from django.urls import path
from .views import *

app_name = 'cart'

urlpatterns = [
    path('', CartIndex, name='cart_index'),
    path('add-product/', AddProduct, name='add_product'),
    path('update-product/', UpdateProduct, name='update_product'),
    path('remove-product/', RemoveProduct, name='remove_product'),
]