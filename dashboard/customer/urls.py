from django.urls import path
from .views import *

app_name = 'customer'

urlpatterns = [
    path('home/', customer_dashboard_home, name='home'),
    path('security-edit/', security_edit, name='security-edit'),
    path('profile-edit/', profile_edit, name='profile-edit'),
    path('profile-edit/image/', profile_edit_image, name='profile-edit-image'),
]
