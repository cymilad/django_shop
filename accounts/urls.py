from django.urls import path
from .views import *

app_name = 'accounts'

urlpatterns = [
    path('login', login_user, name='login'),
    path('logout', logout_user, name='logout'),
    path('signup', signup_user, name='signup'),
    path('reset-password', reset_password_user, name='reset_password'),
    path('reset-password/<str:token>', password_reset_confirm, name='password_reset_confirm'),
    path('activate/<str:token>/', activate_account, name='activate-account'),
]