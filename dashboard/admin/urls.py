from django.urls import path
from .views import *

app_name = 'admin'

urlpatterns = [
    path('home/', admin_dashboard_home, name='home'),
]
