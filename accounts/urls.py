from django.urls import path
from .views import *

app_name = 'accounts'

urlpatterns = [
    path('login', login_user, name='login'),
    path('logout', logout_user, name='logout'),
    # path('register', register_user, name='register'),
    # path('reset-password', reset_password_user, name='reset_password'),
    path('activate/<str:token>/', activate_account, name='activate-account'),
]