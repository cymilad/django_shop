from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_POST
from django.http import HttpResponseForbidden
from django.contrib import messages
from functools import wraps
from accounts.models import Profile, UserType
import os


def customer_required(view_func):
    @wraps(view_func)
    @login_required(login_url='accounts:login')
    def _wrapped_view(request, *args, **kwargs):
        if request.user.type != UserType.customer.value:
            return HttpResponseForbidden("شما دسترسی مشتری ندارید")
        return view_func(request, *args, **kwargs)

    return _wrapped_view


@customer_required
def customer_dashboard_home(request):
    data = {}
    return render(request, 'dashboard/customer/home.html', data)


@customer_required
def security_edit(request):
    if request.method == "POST":
        old_password = request.POST.get('old_password')
        new_password = request.POST.get('new_password')
        confirm_password = request.POST.get('confirm_password')

        # Check field not empty
        if not old_password or not new_password or not confirm_password:
            messages.error(request, "تمام فیلد ها الزامی هستند")
            return redirect("dashboard:customer:security-edit")

        # Checking the consistency of two new passwords
        if new_password != confirm_password:
            messages.error(request, "رمزعبور جدید و تکرار آن مطابقت ندارند")
            return redirect("dashboard:customer:security-edit")

        # Check current password
        if not request.user.check_password(old_password):
            messages.error(request, 'رمزعبور فعلی اشتباه است')
            return redirect("dashboard:customer:security-edit")

        # Minimum password length validation (8)
        if len(new_password) < 8:
            messages.error(request, 'رمزعبور باید حداقل 8 کاراکتر باشد')
            return redirect("dashboard:customer:security-edit")

        # Change passowrd
        request.user.set_password(new_password)
        request.user.save()
        update_session_auth_hash(request, request.user)

        messages.success(request, 'بروزرسانی رمز عبور با موفقیت انجام شد')
        return redirect("dashboard:customer:security-edit")

    return render(request, 'dashboard/customer/profile/security-edit.html')


@customer_required
def profile_edit(request):
    try:
        profile = Profile.objects.get(user=request.user)
    except Profile.DoesNotExist:
        messages.error(request, "پروفایل یافت نشد")
        return redirect("dashboard:customer:profile-edit")

    if request.method == "POST":
        first_name = request.POST.get("first_name")
        last_name = request.POST.get("last_name")
        phone_number = request.POST.get("phone_number")

        if not first_name or not last_name or not phone_number:
            messages.error(request, 'تمام فیلد ها الزامی هستند')
        elif not phone_number.isdigit() or len(phone_number) != 11:
            messages.error(request, 'شماره موبایل باید دقیقاً 11 رقم باشد')
        else:
            profile.first_name = first_name
            profile.last_name = last_name
            profile.phone_number = phone_number
            profile.save()
            messages.success(request, 'بروزرسانی پروفایل با موفقیت انجام شد')
            return redirect("dashboard:customer:profile-edit")

    data = {
        'profile': profile,
    }

    return render(request, 'dashboard/customer/profile/profile-edit.html', data)


@customer_required
@require_POST
def profile_edit_image(request):
    profile = get_object_or_404(Profile, user=request.user)

    if "image" not in request.FILES:
        messages.error(request, "ارسال تصویر با مشکل مواجه شده لطفاً مجدد بررسی و تلاش نمایید")
        return redirect("dashboard:customer:profile-edit")

    image = request.FILES["image"]
    allowed_types = ["image/jpeg", "image/png"]
    allowed_extensions = [".jpg", ".jpeg", ".png"]

    # review content type
    if image.content_type not in allowed_types:
        messages.error(request, "فقط فرمت‌های JPG و PNG مجاز هستند")
        return redirect(f"dashboard:customer:profile-edit")

    ext = os.path.splitext(image.name)[1].lower()
    if ext not in allowed_extensions:
        messages.error(request, 'فقط فرمت‌های JPG و PNG مجاز هستند')
        return redirect("dashboard:customer:profile-edit")

    profile.image = image

    try:
        profile.save()
        messages.success(request, "بروزرسانی تصویر پروفایل با موفقیت انجام شد")
    except:
        messages.error(request, "ارسال تصویر با مشکل مواجه شده لطفاً مجدد بررسی و تلاش نمایید")

    return redirect("dashboard:customer:profile-edit")
