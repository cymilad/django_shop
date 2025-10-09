from django.urls import path, include
from .views import *

app_name = 'dashboard'

urlpatterns = [
    path('home/', dashboard_home, name='home'),
    path('admin/', include('dashboard.admin.urls')),
    path('customer/', include('dashboard.customer.urls')),
]
