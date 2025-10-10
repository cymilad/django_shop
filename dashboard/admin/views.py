from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_POST
from django.http import HttpResponseForbidden
from accounts.models import Profile, UserType
from django.contrib import messages
from functools import wraps
import os


def admin_required(view_func):
    @wraps(view_func)
    @login_required(login_url='accounts:login')
    def warapped_view(request, *args, **kwargs):
        if request.user.type != UserType.superuser.value and request.user.type != UserType.admin.value:
            return HttpResponseForbidden("شما دسترسی ادمین ندارید")
        return view_func(request, *args, **kwargs)

    return warapped_view


@admin_required
def admin_dashboard_home(request):
    data = {}
    return render(request, 'dashboard/admin/home.html', data)


@admin_required
def security_edit(request):
    if request.method == "POST":
        old_password = request.POST.get('old_password')
        new_password = request.POST.get('new_password')
        confirm_password = request.POST.get('confirm_password')

        # Check field not empty
        if not old_password or not new_password or not confirm_password:
            messages.error(request, "تمام فیلد ها الزامی هستند")
            return redirect("dashboard:admin:security-edit")

        # Checking the consistency of two new passwords
        if new_password != confirm_password:
            messages.error(request, "رمزعبور جدید و تکرار آن مطابقت ندارند")
            return redirect("dashboard:admin:security-edit")

        # Check current password
        if not request.user.check_password(old_password):
            messages.error(request, 'رمزعبور فعلی اشتباه است')
            return redirect("dashboard:admin:security-edit")

        # Minimum password length validation (8)
        if len(new_password) < 8:
            messages.error(request, 'رمزعبور باید حداقل 8 کاراکتر باشد')
            return redirect("dashboard:admin:security-edit")

        # Change passowrd
        request.user.set_password(new_password)
        request.user.save()
        update_session_auth_hash(request, request.user)

        messages.success(request, 'بروزرسانی رمز عبور با موفقیت انجام شد')
        return redirect("dashboard:admin:security-edit")

    return render(request, 'dashboard/admin/profile/security-edit.html')


@admin_required
def profile_edit(request):
    try:
        profile = Profile.objects.get(user=request.user)
    except Profile.DoesNotExist:
        messages.error(request, "پروفایل یافت نشد")
        return redirect("dashboard:admin:profile-edit")

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
            return redirect("dashboard:admin:profile-edit")

    data = {
        'profile': profile,
    }

    return render(request, 'dashboard/admin/profile/profile-edit.html', data)


@admin_required
@require_POST
def profile_edit_image(request):
    profile = get_object_or_404(Profile, user=request.user)

    if "image" not in request.FILES:
        messages.error(request, "ارسال تصویر با مشکل مواجه شده لطفاً مجدد بررسی و تلاش نمایید")
        return redirect("dashboard:admin:profile-edit")

    image = request.FILES["image"]
    allowed_types = ["image/jpeg", "image/png"]
    allowed_extensions = [".jpg", ".jpeg", ".png"]

    # review content type
    if image.content_type not in allowed_types:
        messages.error(request, "فقط فرمت‌های JPG و PNG مجاز هستند")
        return redirect(f"dashboard:admin:profile-edit")

    ext = os.path.splitext(image.name)[1].lower()
    if ext not in allowed_extensions:
        messages.error(request, 'فقط فرمت‌های JPG و PNG مجاز هستند')
        return redirect("dashboard:admin:profile-edit")

    profile.image = image

    profile.image = request.FILES["image"]

    try:
        profile.save()
        messages.success(request, "بروزرسانی تصویر پروفایل با موفقیت انجام شد")
    except:
        messages.error(request, "ارسال تصویر با مشکل مواجه شده لطفاً مجدد بررسی و تلاش نمایید")

    return redirect("dashboard:admin:profile-edit")
