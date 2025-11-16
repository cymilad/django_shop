from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.shortcuts import redirect
from shop.models import Product, StatusType
from .models import Review


@login_required
def submit_review(request):
    if request.method == "POST":
        product_id = request.POST.get("product")
        rate = request.POST.get("rate")
        description = request.POST.get("description")

        if not product_id or not rate or not description:
            messages.error(request, "تمام فیلدها اجباری است.")
            return redirect(request.META.get("HTTP_REFERER", "/"))

        try:
            product = Product.objects.get(id=product_id, status=StatusType.publish.value)
        except Product.DoesNotExist:
            messages.error(request, "این محصول وجود ندارد یا منتشر نشده است.")
            return redirect(request.META.get('HTTP_REFERER', '/'))

        Review.objects.create(
            user=request.user,
            product=product,
            rate=rate,
            description=description,
        )

        messages.success(request, "دیدگاه شما با موفقیت ثبت شد و پس از بررسی نمایش داده خواهد شد.")
        return redirect("shop:product_detail", slug=product.slug)

    return redirect("website:index")
