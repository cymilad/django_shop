from django.urls import path
from .views import *

app_name = 'customer'

urlpatterns = [
    path('home/', customer_dashboard_home, name='home'),
]
