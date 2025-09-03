from django.db import models
from django.dispatch import receiver
from django.db.models.signals import post_save
from django.contrib.auth.base_user import BaseUserManager
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from .validators import validate_iranian_cellphone_number


class UserType(models.IntegerChoices):
    customer = 1, _('customer')
    admin = 2, _('admin')
    superuser = 3, _('superuser')


class UserManager(BaseUserManager):
    """
    Custom user model manager for Create Users.
    """

    # Create custom user
    def create_user(self, email, password, **extra_fields):
        if not email:
            raise ValueError(_('The email must be set'))
        email = self.normalize_email(email)  # Example@GMAIL.COM => example@gmail.com
        user = self.model(email=email, **extra_fields)  # get email and password or othear fields
        user.set_password(password)  # password hash
        user.save()  # save and create user
        return user

    # Create SuperUser
    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_staff', True)  # Access to the admin section
        extra_fields.setdefault('is_superuser', True)  # Full power over all users
        extra_fields.setdefault('is_active', True)  # Account activation
        extra_fields.setdefault('is_verified', True)  # Email or account verification
        extra_fields.setdefault('type', UserType.superuser.value)  # User type

        if extra_fields.get('is_staff') is not True:
            raise ValueError(_('Superuser must have is_staff=True.'))
        if extra_fields.get('is_superuser') is not True:
            raise ValueError(_('Superuser must have is_superuser=True.'))
        return self.create_user(email, password, **extra_fields)


class User(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(_('email address'), unique=True)  # User email and unique
    is_staff = models.BooleanField(default=False)  # Access to the administration section
    is_active = models.BooleanField(default=True)  # Account activation
    is_verified = models.BooleanField(default=False)  # Account verification
    type = models.IntegerField(choices=UserType.choices, default=UserType.customer.value)  # User type (customer/admin/superuser)
    created_date = models.DateTimeField(auto_now_add=True)  # Creation time
    updated_date = models.DateTimeField(auto_now=True)  # Time last update

    USERNAME_FIELD = 'email'  # Email replaced username
    REQUIRED_FIELDS = []  # No other fields are required.
    objects = UserManager()  # Use our custom management

    # When we print a user, their email is displayed.
    def __str__(self):
        return self.email


class Profile(models.Model):
    user = models.OneToOneField('User', on_delete=models.CASCADE, related_name='user_profile')
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    phone_number = models.CharField(max_length=12, validators=[validate_iranian_cellphone_number])
    image = models.ImageField(upload_to='profile/', default='profile/default.jpg')
    created_date = models.DateTimeField(auto_now_add=True)
    updated_date = models.DateTimeField(auto_now=True)

    def get_fullname(self):
        if self.first_name and self.last_name:
            return f'{self.first_name} {self.last_name}'
        return f'کاربر جدید'


#
@receiver(post_save, sender=User)
def create_profile(sender, instance, created, **kwargs):
    """
    با این کار، همیشه بعد از ثبت نام یک پروفایل خالی برای کاربر ساخته می‌شود و لازم نیست دستی بسازیم
    """
    if created:
        Profile.objects.create(user=instance, pk=instance.pk)
