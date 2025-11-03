from django.contrib import admin
from payment.models import *


@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ["id", "authority_id", "amount", "response_code", "status", "created_date"]
