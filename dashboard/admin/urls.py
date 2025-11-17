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
    path('order/list/', order_list, name='order-list'),
    path('order/detail/<int:pk>', order_detail, name='order-detail'),
    path('order/invoice/<int:pk>', order_invoice, name='order-invoice'),
    path('review/list/', review_list, name='review-list'),
    path('review/edit/<int:pk>', review_edit, name='review-edit'),
    path('coupon/list/', coupon_list, name='coupon-list'),
    path('coupon/create/', coupon_create, name='coupon-create'),
    path('coupon/edit/<int:pk>', coupon_edit, name='coupon-edit'),
    path('coupon/delete/<int:pk>', coupon_delete, name='coupon-delete'),
    path('category/list/', category_list, name='category-list'),
    path('category/create/', category_create, name='category-create'),
    path('category/edit/<int:pk>', category_edit, name='category-edit'),
    path('category/delete/<int:pk>', category_delete, name='category-delete'),
    path('user/list/', user_list, name='user-list'),
    path('user/edit/<int:pk>', user_edit, name='user-edit'),
]
