from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import update_session_auth_hash
from django.contrib.auth.decorators import login_required
from django.views.decorators.http import require_POST
from django.http import HttpResponseForbidden, JsonResponse
from django.contrib import messages
from django.core.paginator import Paginator
from django.core.exceptions import FieldError
from django.utils.text import slugify
from django.db import IntegrityError
from decimal import Decimal
from functools import wraps
from datetime import datetime
from accounts.models import Profile, UserType
from shop.models import Product, Category, StatusType
from order.models import Order, OrderStatusType, Coupon
from review.models import Review, ReviewStatusType
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


@admin_required
def products(request):
    queryset = Product.objects.all()

    search_q = request.GET.get("q")
    if search_q:
        queryset = queryset.filter(title__icontains=search_q)

    category_id = request.GET.get("category_id")
    if category_id:
        queryset = queryset.filter(category__id=category_id)

    min_price = request.GET.get("min_price")
    if min_price:
        queryset = queryset.filter(price__gte=min_price)

    max_price = request.GET.get("max_price")
    if max_price:
        queryset = queryset.filter(price__lte=max_price)

    order_by = request.GET.get("order_by")
    if order_by:
        try:
            queryset = queryset.order_by(order_by)
        except FieldError:
            pass

    page_size = request.GET.get("page_size", 10)
    paginator = Paginator(queryset, page_size)
    page_number = request.GET.get("page")
    page_obj = paginator.get_page(page_number)

    params = request.GET.copy()
    if "page" in params:
        params.pop("page")
    query_string = params.urlencode()

    data = {
        "object_list": page_obj.object_list,
        "page_obj": page_obj,
        "total_items": queryset.count(),
        "categories": Category.objects.all(),
        "query_string": query_string,
    }

    return render(request, 'dashboard/admin/products/product-list.html', data)


@admin_required
def products_edit(request, pk):
    product = get_object_or_404(Product, pk=pk)

    if request.method == "POST":
        title = request.POST.get("title")
        slug = request.POST.get("slug")
        description = request.POST.get("description")
        brief_description = request.POST.get("brief_description")
        stock = request.POST.get("stock")
        status = request.POST.get("status")
        price = request.POST.get("price")
        discount_percent = request.POST.get("discount_percent")
        category_ids = request.POST.getlist("category[]")

        if not title or not slug or not description or not brief_description or not stock or not status or not price or not category_ids:
            messages.error(request, "لطفاً همه فیلد ها را پر کنید")
            data = {
                "product": product,
                "categories": Category.objects.all(),
                "StatusType": StatusType,
            }
            return render(request, 'dashboard/admin/products/product-edit.html', data)

        product.title = title
        product.slug = slug
        product.description = description
        product.brief_description = brief_description
        product.stock = stock
        product.status = status
        product.price = price
        product.discount_percent = discount_percent
        product.category.set(category_ids)

        if "image" in request.FILES:
            product.image = request.FILES.get("image")

        product.save()
        messages.success(request, "ویرایش محصول با موفقیت انجام شد")
        return redirect("dashboard:admin:products-edit", pk=product.pk)

    data = {
        "product": product,
        "categories": Category.objects.all(),
        "StatusType": StatusType,
    }
    return render(request, "dashboard/admin/products/product-edit.html", data)


@admin_required
def products_delete(request, pk):
    if request.method == "POST":
        product = get_object_or_404(Product, pk=pk)
        product.delete()
        return JsonResponse({"success": True, "message": "محصول با موفقیت حذف شد"})
    return JsonResponse({"success": False, "message": "روش نامعتبر"})


@admin_required
def products_create(request):
    if request.method == "POST":
        title = request.POST.get("title", "").strip()
        slug_input = request.POST.get("slug", "").strip()
        description = request.POST.get("description", "").strip()
        brief_description = request.POST.get("brief_description", "").strip()
        status = request.POST.get("status")
        category_ids = request.POST.getlist("category[]")
        image = request.FILES.get("image")

        slug = slugify(slug_input, allow_unicode=True)
        if not slug:
            messages.error(request, "لطفاً اسلاگ معتبر وارد کنید.")
            data = {
                "categories": Category.objects.all(),
                "StatusType": StatusType
            }
            return render(request, "dashboard/admin/products/product-create.html", data)

        try:
            stock = int(request.POST.get("stock") or 0)
        except ValueError:
            stock = 0

        try:
            price = Decimal(request.POST.get("price") or 0)
        except:
            price = Decimal(0)

        try:
            discount_percent = int(request.POST.get("discount_percent") or 0)
        except ValueError:
            discount_percent = 0

        if not title or not description or not brief_description or not status or not category_ids:
            messages.error(request, "لطفاً همه فیلد ها را پر کنید.")
            data = {
                "categories": Category.objects.all(),
                "StatusType": StatusType
            }
            return render(request, "dashboard/admin/products/product-create.html", data)

        if Product.objects.filter(slug=slug).exists():
            messages.error(request, "محصولی با این اسلاگ از قبل وجود دارد. لطفاً اسلاگ جدیدی وارد کنید.")
            data = {
                "categories": Category.objects.all(),
                "StatusType": StatusType
            }
            return render(request, "dashboard/admin/products/product-create.html", data)

        try:
            product = Product.objects.create(
                title=title,
                slug=slug,
                description=description,
                brief_description=brief_description,
                stock=stock,
                status=status,
                price=price,
                discount_percent=discount_percent,
                image=image,
                user=request.user
            )

            product.category.set(category_ids)

            messages.success(request, "ایجاد محصول با موفقیت انجام شد.")
            return redirect("dashboard:admin:products-create")

        except IntegrityError as e:
            messages.error(request, f"خطا در ذخیره‌ سازی محصول: {e}")

    data = {
        "categories": Category.objects.all(),
        "StatusType": StatusType
    }
    return render(request, "dashboard/admin/products/product-create.html", data)


@admin_required
def order_list(request):
    queryset = Order.objects.all()

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
    return render(request, "dashboard/admin/order/order-list.html", data)


@admin_required
def order_detail(request, pk):
    order = get_object_or_404(Order, pk=pk)
    profile = Profile.objects.all()

    data = {
        "item": order,
        "profile": profile,
    }
    return render(request, "dashboard/admin/order/order-detail.html", data)


@admin_required
def order_invoice(request, pk):
    order = get_object_or_404(Order, pk=pk, status=OrderStatusType.success.value)
    profile = Profile.objects.all()

    data = {
        "item": order,
        "profile": profile,
    }
    return render(request, 'dashboard/admin/order/order-invoice.html', data)


@admin_required
def review_list(request):
    queryset = Review.objects.all()

    search_q = request.GET.get("q")
    if search_q:
        queryset = queryset.filter(product__title__icontains=search_q)

    status = request.GET.get("status")
    if status:
        queryset = queryset.filter(status=status)

    order_by = request.GET.get("order_by")
    if order_by:
        try:
            queryset = queryset.order_by(order_by)
        except FieldError:
            pass

    paginate_by = int(request.GET.get("page_size", 10))
    pageinator = Paginator(queryset, paginate_by)
    page_number = request.GET.get("page")
    page_obj = pageinator.get_page(page_number)

    data = {
        "items": page_obj,
        "page_obj": page_obj,
        "total_items": queryset.count(),
        "status_types": ReviewStatusType.choices,
    }
    return render(request, "dashboard/admin/review/review-list.html", data)


@admin_required
def review_edit(request, pk):
    review = get_object_or_404(Review, pk=pk)
    status_choices = Review._meta.get_field('status').choices

    if request.method == "POST":
        description = request.POST.get("description")
        rate = request.POST.get("rate")
        status = request.POST.get("status")

        if not description or not rate or not status:
            messages.error(request, "تمام فیلدها ضروری هستند.")
            return redirect('dashboard:admin:review-edit', pk=pk)

        review.description = description
        review.rate = rate
        review.status = status
        review.save()

        messages.error(request, "تغییرات با موفقیت اعمال شد")
        return redirect('dashboard:admin:review-edit', pk=pk)

    data = {
        "review": review,
        "status_choices": status_choices,
    }

    return render(request, "dashboard/admin/review/review-edit.html", data)


@admin_required
def coupon_list(request):
    queryset = Coupon.objects.all()

    search_q = request.GET.get("q")
    if search_q:
        queryset = queryset.filter(code__icontains=search_q)

    order_by = request.GET.get("order_by")
    if order_by:
        try:
            queryset = queryset.order_by(order_by)
        except FieldError:
            pass

    paginate_by = int(request.GET.get("page_size", 10))
    pageinator = Paginator(queryset, paginate_by)
    page_number = request.GET.get("page")
    page_obj = pageinator.get_page(page_number)

    data = {
        "items": page_obj,
        "page_obj": page_obj,
        "total_items": queryset.count(),
    }
    return render(request, "dashboard/admin/coupons/coupon-list.html", data)


@admin_required
def coupon_edit(request, pk):
    coupon = get_object_or_404(Coupon, pk=pk)

    if request.method == "POST":
        code = request.POST.get("code")
        discount_percent = request.POST.get("discount_percent")
        max_limit_usage = request.POST.get("max_limit_usage")
        date_str = request.POST.get("expiration_date")
        time_str = request.POST.get("expiration_time")

        if not code or not discount_percent or not max_limit_usage:
            messages.error(request, "تمام فیلدها ضروری هستند.")
            return redirect('dashboard:admin:coupon-edit', pk=pk)

        coupon.code = code
        coupon.discount_percent = discount_percent
        coupon.max_limit_usage = max_limit_usage
        if date_str and time_str:
            expiration_datetime = datetime.strptime(f"{date_str} {time_str}", "%Y-%m-%d %H:%M")
            coupon.expiration_date = expiration_datetime
        else:
            coupon.expiration_date = None
        coupon.save()

        messages.success(request, "ویرایش تخفیف با موفقیت انجام شد")
        return redirect('dashboard:admin:coupon-edit', pk=pk)

    data = {
        "coupon": coupon,
    }

    return render(request, "dashboard/admin/coupons/coupon-edit.html", data)


@admin_required
def coupon_create(request):
    if request.method == "POST":
        code = request.POST.get("code")
        discount_percent = request.POST.get("discount_percent")
        max_limit_usage = request.POST.get("max_limit_usage")
        expiration_date_str = request.POST.get("expiration_date")
        expiration_time_str = request.POST.get("expiration_time")

        if not code or not discount_percent or not max_limit_usage:
            messages.error(request, "تمام فیلدها ضروری هستند.")
            return redirect("dashboard:admin:coupon-create")

        expiration_datetime = None
        if expiration_date_str and expiration_time_str:
            expiration_datetime = datetime.strptime(
                f"{expiration_date_str} {expiration_time_str}", "%Y-%m-%d %H:%M")

        Coupon.objects.create(
            code=code,
            discount_percent=discount_percent,
            max_limit_usage=max_limit_usage,
            expiration_date=expiration_datetime,
        )
        messages.success(request, "ایجاد تخفیف با موفقیت انجام شد")
        return redirect('dashboard:admin:coupon-create')

    return render(request, "dashboard/admin/coupons/coupon-create.html")


@admin_required
def coupon_delete(request, pk):
    if request.method == "POST":
        coupon = get_object_or_404(Coupon, pk=pk)

        related_orders = Order.objects.filter(coupon=coupon)
        if related_orders.exists():
            return JsonResponse({
                "success": False,
                "message": "این کد تخفیف در سفارش‌ هایی استفاده شده و نمی‌ توان آن را حذف کرد."
            })

        coupon.delete()
        return JsonResponse({"success": True, "message": "کد تخفیف با موفقیت حذف شد"})
    return JsonResponse({"success": False, "message": "روش نامعتبر"})


@admin_required
def category_list(request):
    queryset = Category.objects.all()

    search_q = request.GET.get("q")
    if search_q:
        queryset = queryset.filter(title__icontains=search_q)

    order_by = request.GET.get("order_by")
    if order_by:
        try:
            queryset = queryset.order_by(order_by)
        except FieldError:
            pass

    paginate_by = int(request.GET.get("page_size", 10))
    pageinator = Paginator(queryset, paginate_by)
    page_number = request.GET.get("page")
    page_obj = pageinator.get_page(page_number)

    data = {
        "items": page_obj,
        "page_obj": page_obj,
        "total_items": queryset.count(),
    }
    return render(request, "dashboard/admin/category/category-list.html", data)

@admin_required
def category_create(request):
    if request.method == "POST":
        title = request.POST.get("title")
        category_slug = request.POST.get("category_slug")

        if not title or not category_slug:
            messages.error(request, "تمام فیلدها ضروری هستند.")
            return redirect("dashboard:admin:category-create")

        Category.objects.create(
            title=title,
            slug=category_slug,
        )

        messages.success(request, "دسته بندی با موفقیت ایجاد شد.")
        return redirect("dashboard:admin:category-create")

    return render(request, 'dashboard/admin/category/category-create.html')

@admin_required
def category_edit(request, pk):
    category = get_object_or_404(Category, pk=pk)

    if request.method == "POST":
        title = request.POST.get("title")
        category_slug = request.POST.get("category_slug")

        if not title or not category_slug:
            messages.error(request, "تمام فیلدها ضروری هستند.")
            return redirect('dashboard:admin:category-edit', pk=pk)

        category.title = title
        category.slug = category_slug
        category.save()

        messages.success(request, "ویرایش دسته بندی با موفقیت انجام شد")
        return redirect('dashboard:admin:category-edit', pk=pk)

    data = {
        "category": category,
    }

    return render(request, "dashboard/admin/category/category-edit.html", data)

@admin_required
def category_delete(request, pk):
    if request.method == "POST":
        category = get_object_or_404(Category, pk=pk)
        category.delete()
        return JsonResponse({"success": True, "message": "دسته بندی با موفقیت حذف شد"})
    return JsonResponse({"success": False, "message": "روش نامعتبر"})