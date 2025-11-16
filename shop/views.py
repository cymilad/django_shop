from django.http import JsonResponse
from django.shortcuts import render, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.core.exceptions import FieldError
from urllib.parse import urlencode
from .models import *
from review.models import Review, ReviewStatusType


def index(request):
    categories = Category.objects.all()
    products = Product.objects.filter(status=StatusType.publish)

    search_q = request.GET.get("q")
    if search_q:
        products = products.filter(title__icontains=search_q)

    category_id = request.GET.get("category_id")
    if category_id:
        products = products.filter(category__id=category_id)

    min_price = request.GET.get("min_price")
    if min_price:
        min_price = min_price.replace(",", "")
        products = products.filter(price__gte=min_price)

    max_price = request.GET.get("max_price")
    if max_price:
        max_price = max_price.replace(",", "")
        products = products.filter(price__lte=max_price)

    order_by = request.GET.get("order_by")
    if order_by:
        try:
            products = products.order_by(order_by)
        except FieldError:
            pass

    page_size = request.GET.get("page_size")
    try:
        page_size = int(page_size)
    except (TypeError, ValueError):
        page_size = 6

    wishlist_items = []
    if request.user.is_authenticated:
        wishlist_items = Wishlist.objects.filter(user=request.user).values_list("product__id", flat=True)

    pageinator = Paginator(products, page_size)
    page_number = request.GET.get('page')
    page_obj = pageinator.get_page(page_number)

    query = request.GET.copy()
    if "page" in query:
        query.pop("page")
    query_string = urlencode(query)

    data = {
        'page_obj': page_obj,
        'categories': categories,
        'query_string': query_string,
        'wishlist_items': wishlist_items,
    }
    return render(request, 'shop/products-grid.html', data)


def product_detail(request, slug):
    products = get_object_or_404(Product, status=StatusType.publish, slug=slug)

    wishlist_items = []
    if request.user.is_authenticated:
        wishlist_items = Wishlist.objects.filter(user=request.user).values_list("product__id", flat=True)

    is_wished = False
    if request.user.is_authenticated:
        is_wished = Wishlist.objects.filter(user=request.user, product=products).exists()

    similar_product = Product.objects.filter(
        status=StatusType.publish,
        category__in=products.category.all()
    ).exclude(id=products.id).distinct().order_by('-id')[:4]

    reviews = Review.objects.filter(product=products, status=ReviewStatusType.accepted.value)

    total_reviews_count = reviews.count()

    reviews_count = {
        f"rate_{rate}": reviews.filter(rate=rate).count() for rate in range(1, 6)
    }

    if total_reviews_count != 0:
        reviews_avg = {
            f"rate_{rate}": round((reviews.filter(rate=rate).count() / total_reviews_count) * 100, 2)
            for rate in range(1, 6)
        }
    else:
        reviews_avg = {f"rate_{rate}": 0 for rate in range(1, 6)}

    data = {
        'products': products,
        'similar_product': similar_product,
        'wishlist_items': wishlist_items,
        'is_wished': is_wished,
        "reviews": reviews,
        "reviews_count": reviews_count,
        "reviews_avg": reviews_avg,
    }
    return render(request, 'shop/products-detail.html', data)


@login_required
def add_or_remove_wishlist(request):
    if request.method == 'POST':
        product_id = request.POST.get('product_id')
        messages = ""

        if product_id:
            try:
                wishlist_item = Wishlist.objects.get(user=request.user, product__id=product_id)
                wishlist_item.delete()
                messages = "محصول از لیست علایق حذف شد"
            except Wishlist.DoesNotExist:
                Wishlist.objects.create(user=request.user, product_id=product_id)
                messages = "محصول به لیست علایق اضافه شد"

        return JsonResponse({'messages': messages})

    return JsonResponse({'error': "Invalid request method"}, status=400)
