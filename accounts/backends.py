from django.contrib.auth.backends import ModelBackend
from .models import User


class VerifiedEmailBackend(ModelBackend):
    def authenticate(self, request, username=None, password=None, **kwargs):
        try:
            user = User.objects.get(email=username)
            if user.check_password(password) and user.is_verified and user.is_active:
                return user
        except User.DoesNotExist:
            return None
