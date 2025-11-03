from django.shortcuts import redirect ,get_object_or_404
from django.http import HttpResponseBadRequest
from order.models import Order
from payment.models import Payment
from payment.zibal_client import ZibalAPI


def verify(request):
    track_id = request.GET.get("trackId")
    success = request.GET.get("success")

    if not track_id or success is None:
        return HttpResponseBadRequest("پارامترهای ارسالی نامعتبر هستند")

    payment = get_object_or_404(Payment, authority_id=track_id)
    order = get_object_or_404(Order, payment=payment)

    # بررسی وضعیت موفقیت اولیه (success=1)
    if success != "1":
        payment.status = 3 # failed
        payment.save()
        order.status = 3
        order.save()
        return redirect("order:failed")

    # تایید نهایی با API زیبال
    zibal = ZibalAPI()
    result = zibal.payment_verify(track_id)

    if result.get("result") == 100:
        payment.status = 2 # success
        payment.ref_id = result.get("refNumber")
        payment.response_json = result
        payment.save()

        order.status = 2
        order.save()

        return redirect("order:completed")
    else:
        payment.status = 3 # failed
        payment.save()
        order.status = 3
        order.save()

        return redirect("order:failed")