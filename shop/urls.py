from django.urls import path, re_path
from .views import *

app_name = 'shop'

urlpatterns = [
    path('', index, name='index'),
    re_path(r"(?P<slug>[-\w]+)/", product_detail, name='product_detail'),
]
