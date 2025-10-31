from django.urls import path
from .views import *

app_name = "order"

urlpatterns = [
    path("checkout/", checkout, name="checkout"),
]
