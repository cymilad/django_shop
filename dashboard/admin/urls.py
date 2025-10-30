from django.urls import path
from .views import *

app_name = 'admin'

urlpatterns = [
    path('home/', admin_dashboard_home, name='home'),
    path('security/edit/', security_edit, name='security-edit'),
    path('profile/edit/', profile_edit, name='profile-edit'),
    path('profile/edit/image/', profile_edit_image, name='profile-edit-image'),
    path('products/', products, name='products'),
    path('products/create/', products_create, name='products-create'),
    path('products/edit/<int:pk>', products_edit, name='products-edit'),
    path('products/delete/<int:pk>', products_delete, name='products-delete'),
]
