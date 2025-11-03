import requests
from django.conf import settings


def get_domain():
    """برمی‌گرداند دامنه سایت برای callback URL."""
    try:
        from django.contrib.sites.models import Site
        return Site.objects.get_current().domain
    except Exception:
        return "example.com"


def get_protocol():
    """تعیین پروتکل بر اساس تنظیمات SSL."""
    return 'https' if getattr(settings, 'SECURE_SSL_REDIRECT', False) else 'http'


class ZibalAPI:
    """
    کلاس مدیریت پرداخت با درگاه Zibal
    مستندات رسمی: https://help.zibal.ir/IPG/API
    """

    payment_request_url = "https://gateway.zibal.ir/v1/request"
    payment_verify_url = "https://gateway.zibal.ir/v1/verify"
    payment_page_url = "https://gateway.zibal.ir/start/"

    def __init__(self, merchant_id=None, callback_url=None):
        # خواندن شناسه پذیرنده از تنظیمات یا ورودی
        self.merchant_id = merchant_id or getattr(settings, "ZIBAL_MERCHANT_ID", None)
        if not self.merchant_id:
            raise ValueError("ZIBAL_MERCHANT_ID در تنظیمات یافت نشد یا در ورودی مشخص نشده است.")

        # خواندن callback از تنظیمات یا ساخت خودکار
        self.callback_url = (
            callback_url
            or getattr(settings, "ZIBAL_CALLBACK_URL", None)
            or f"{get_protocol()}://{get_domain()}/payment/zibal/verify"
        )

    def payment_request(self, amount, description="پرداخت کاربر", order_id=None, mobile=None, email=None):
        """
        ایجاد درخواست پرداخت در زیبال و دریافت trackId
        """
        payload = {
            "merchant": self.merchant_id,
            "amount": int(amount),
            "callbackUrl": self.callback_url,
            "description": description,
        }

        # پارامترهای اختیاری
        if order_id:
            payload["orderId"] = str(order_id)
        if mobile:
            payload["mobile"] = str(mobile)
        if email:
            payload["email"] = str(email)

        headers = {"Content-Type": "application/json"}

        response = requests.post(self.payment_request_url, headers=headers, json=payload, timeout=10)
        return response.json()

    def payment_verify(self, track_id):
        """
        تأیید وضعیت پرداخت با trackId
        """
        payload = {
            "merchant": self.merchant_id,
            "trackId": track_id
        }

        headers = {"Content-Type": "application/json"}
        response = requests.post(self.payment_verify_url, headers=headers, json=payload, timeout=10)
        return response.json()

    def generate_payment_url(self, track_id):
        """
        تولید لینک پرداخت برای کاربر
        """
        return f"{self.payment_page_url}{track_id}"