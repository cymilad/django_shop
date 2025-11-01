from django.shortcuts import render, get_object_or_404, redirect
from django.http import JsonResponse
from django.utils import timezone
from cart.cart import CartSession
from .permission import customer_required
from .models import *
from cart.models import Cart


@customer_required
def checkout(request):
    user = request.user

    if request.method == 'POST':
        address_id = request.POST.get('address_id')
        coupon_code = request.POST.get('coupon')

        # اعتبار سنجی آدرس
        try:
            address = UserAddress.objects.get(id=address_id, user=user)
        except (UserAddress.DoesNotExist, TypeError, ValueError):
            return JsonResponse({"error": "آدرس انتخابی نامعتبر است"}, status=400)

        # اعتبار سنجی سبد خرید
        try:
            cart = Cart.objects.get(user=user)
        except Cart.DoesNotExist:
            return JsonResponse({"error": "سبد خرید شما خالی است"}, status=400)

        # ساخت سفارش
        order = Order.objects.create(
            user=user,
            address=address.address,
            state=address.state,
            city=address.city,
            zip_code=address.zip_code,
        )

        # افزودن آیتم‌های سبد به سفارش
        for item in cart.cart_items.all():
            OrderItem.objects.create(
                order=order,
                product=item.product,
                quantity=item.quantity,
                price=item.product.get_price(),
            )

        # پاک کردن سبد
        cart.cart_items.all().delete()
        CartSession(request.session).clear()

        # محاسبه مبلغ نهایی
        total_price = order.calculate_total_price()

        # بررسی کوپن (در صورت وجود)
        if coupon_code:
            try:
                coupon = Coupon.objects.get(code=coupon_code)
            except Coupon.DoesNotExist:
                return JsonResponse({"error": "کد تخفیف اشتباه است"}, status=400)

            if coupon.used_by.count() >= coupon.max_limit_usage:
                return JsonResponse({"error": "محدودیت در تعداد استفاده از این کد وجود دارد"}, status=400)

            if coupon.expiration_date and coupon.expiration_date < timezone.now():
                return JsonResponse({"error": "کد تخفیف منقضی شده است"}, status=400)

            if user in coupon.used_by.all():
                return JsonResponse({"error": "شما قبلاً از این کد استفاده کرده‌اید"}, status=400)

            # اعمال تخفیف
            discount_percent = coupon.discount_percent
            total_price = round(total_price - (total_price * (discount_percent / Decimal(100))))
            order.coupon = coupon
            coupon.used_by.add(user)
            coupon.save()

        # ذخیره قیمت نهایی سفارش
        order.total_price = total_price
        order.save()

        return redirect("order:completed")

    cart = get_object_or_404(Cart, user=request.user)
    address = UserAddress.objects.filter(user=request.user)
    total_price = cart.calculate_total_price()
    total_tax = round((total_price * 9) / 100)

    data = {
        "address": address,
        "total_price": total_price,
        "total_tax": total_tax,
    }
    return render(request, 'order/checkout.html', data)

@customer_required
def validatecoupon(request):
    if request.method != 'POST':
        return JsonResponse({"message": "درخواست نامعتبر است"}, status=400)

    code = request.POST.get('code')
    user = request.user

    status_code = 200
    message = "کد تخفیف با موفقیت ثبت شد"
    total_price = 0
    total_tax = 0

    try:
        coupon = Coupon.objects.get(code=code)
    except Coupon.DoesNotExist:
        return JsonResponse({"message": "کد تخفیف یافت نشد"}, status=404)

    if coupon.used_by.count() >= coupon.max_limit_usage:
        status_code, message = 403, "محدودیت در تعداد استفاده"
    elif coupon.expiration_date and coupon.expiration_date < timezone.now():
        status_code, message = 403, "کد تخفیف منقضی شده است"
    elif user in coupon.used_by.all():
        status_code, message = 403, "این کد تخفیف قبلا توسط شما استفاده شده است"
    else:
        cart = Cart.objects.get(user=request.user)
        total_price = cart.calculate_total_price()
        total_price = round(total_price - (total_price * (coupon.discount_percent / 100)))
        total_tax = round((total_price * 9) / 100)

    return JsonResponse({
        "message": message,
        "total_tax": total_tax,
        "total_price": total_price,
    }, status=status_code)


@customer_required
def completed(request):
    data = {}
    return render(request, 'order/completed.html', data)


@customer_required
def failed(request):
    data = {}
    return render(request, 'order/failed.html', data)
