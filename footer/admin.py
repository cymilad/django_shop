from django.contrib import admin
from .models import SocialMedia, Footer_text

@admin.register(SocialMedia)
class SocialMediaAdmin(admin.ModelAdmin):
    list_display = ["id", "telegram", "youtube"]

@admin.register(Footer_text)
class FooterTextAdmin(admin.ModelAdmin):
    list_display = ["id", "address", "phone_number", "text_footer"]