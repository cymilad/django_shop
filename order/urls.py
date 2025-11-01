from django.urls import path
from .views import *

app_name = "order"

urlpatterns = [
    path("checkout/", checkout, name="checkout"),
    path("completed/", completed, name="completed"),
    path("failed/", failed, name="failed"),
    path("validate-coupon/", validatecoupon, name="validatecoupon"),
]
