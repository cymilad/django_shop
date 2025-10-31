from django.urls import path
from .views import *

app_name = 'customer'

urlpatterns = [
    path('home/', customer_dashboard_home, name='home'),

    path('security/edit/', security_edit, name='security-edit'),
    path('profile/edit/', profile_edit, name='profile-edit'),
    path('profile/edit/image/', profile_edit_image, name='profile-edit-image'),

    path('address/create/', address_create, name='address-create'),
    path('address/list/', address_list, name='address-list'),
    path('address/edit/<int:pk>', address_edit, name='address-edit'),
    path('address/delete/<int:pk>', address_delete, name='address-delete'),
]
