from django.urls import path
from .views import *

app_name = 'admin'

urlpatterns = [
    path('home/', admin_dashboard_home, name='home'),
    path('security-edit/', security_edit, name='security-edit'),
    path('profile-edit/', profile_edit, name='profile-edit'),
]
