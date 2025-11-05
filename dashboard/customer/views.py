from pydoc import pager

from django.core.exceptions import FieldError
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_POST
from django.http import HttpResponseForbidden, JsonResponse
from django.core.paginator import Paginator
from django.contrib import messages
from functools import wraps
from accounts.models import Profile, UserType
from order.models import UserAddress, Order, OrderStatusType, OrderItem
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


@customer_required
def address_list(request):
    user_address = UserAddress.objects.filter(user=request.user)
    order_by = request.GET.get("order_by")
    if order_by:
        try:
            user_address = user_address.order_by(order_by)
        except FieldError:
            pass

    data = {
        "user_address": user_address,
    }
    return render(request, "dashboard/customer/address/address-list.html", data)


@customer_required
def address_create(request):
    if request.method == "POST":
        address = request.POST.get("address")
        state = request.POST.get("state")
        city = request.POST.get("city")
        zip_code = request.POST.get("zip_code")

        if not (state and city and address and zip_code):
            messages.error(request, "لطفاً همه فیلد های ضروری را پر کنید.")
            return redirect(request.path)

        UserAddress.objects.create(
            user=request.user,
            address=address,
            state=state,
            city=city,
            zip_code=zip_code,
        )

        messages.success(request, "آدرس با موفقیت ایجاد شد")
        return redirect("dashboard:customer:address-create")

    return render(request, "dashboard/customer/address/address-create.html")


@customer_required
def address_edit(request, pk):
    address_item = get_object_or_404(UserAddress, pk=pk, user=request.user)

    if request.method == "POST":
        address = request.POST.get("address")
        state = request.POST.get("state")
        city = request.POST.get("city")
        zip_code = request.POST.get("zip_code")

        if not (state and city and address and zip_code):
            messages.error(request, "لطفاً همه فیلد های ضروری را پر کنید.")
            return redirect(request.path)

        address_item.address = address
        address_item.state = state
        address_item.city = city
        address_item.zip_code = zip_code
        address_item.save()

        messages.success(request, "ویرایش آدرس با موفقیت انجام شد")
        return redirect("dashboard:customer:address-edit", pk=address_item.pk)

    data = {
        "address_item": address_item,
    }
    return render(request, "dashboard/customer/address/address-edit.html", data)


@customer_required
def address_delete(request, pk):
    if request.method == "POST":
        address_item = get_object_or_404(UserAddress, pk=pk, user=request.user)
        address_item.delete()
        return JsonResponse({
            "success": True,
            "message": "آدرس با موفقیت حذف شد."
        })
    return JsonResponse({"success": False, "message": "روش نامعتبر"})


@customer_required
def order_list(request):
    queryset = Order.objects.filter(user=request.user)

    search_q = request.GET.get("q")
    if search_q:
        queryset = queryset.filter(id__icontains=search_q)

    status = request.GET.get("status")
    if status:
        queryset = queryset.filter(status=status)

    order_by = request.GET.get("order_by")
    if order_by:
        try:
            queryset = queryset.order_by(order_by)
        except FieldError:
            pass

    paginate_by = int(request.GET.get("page_size", 5))
    pageinator = Paginator(queryset, paginate_by)
    page_number = request.GET.get("page")
    page_obj = pageinator.get_page(page_number)

    data = {
        "items": page_obj,
        "page_obj": page_obj,
        "total_items": queryset.count(),
        "status_types": OrderStatusType.choices,
    }
    return render(request, "dashboard/customer/order/order-list.html", data)


@customer_required
def order_detail(request, pk):
    order = get_object_or_404(Order, pk=pk, user=request.user)
    profile = Profile.objects.get(user=request.user)

    data = {
        "item": order,
        "profile": profile,
    }
    return render(request, "dashboard/customer/order/order-detail.html", data)


@customer_required
def order_invoice(request, pk):
    order = get_object_or_404(Order, pk=pk, user=request.user, status=OrderStatusType.success.value)
    profile = Profile.objects.get(user=request.user)

    data = {
        "item": order,
        "profile": profile,
    }
    return render(request, 'dashboard/customer/order/order-invoice.html', data)
