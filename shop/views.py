from django.shortcuts import render, get_object_or_404
from django.core.paginator import Paginator
from django.core.exceptions import FieldError
from urllib.parse import urlencode
from .models import *


def index(request):
    categories = Category.objects.all()
    products = Product.objects.filter(status=StatusType.publish)

    if search_q := request.GET.get("q"):
        products = products.filter(title__icontains=search_q)

    if category_id := request.GET.get("category_id"):
        products = products.filter(category__id=category_id)

    min_price = request.GET.get("min_price")
    if min_price:
        min_price = min_price.replace(",", "")
        products = products.filter(price__gte=min_price)

    max_price = request.GET.get("max_price")
    if max_price:
        max_price = max_price.replace(",", "")
        products = products.filter(price__lte=max_price)

    if order_by := request.GET.get("order_by"):
        try:
            products = products.order_by(order_by)
        except FieldError:
            pass

    page_size = request.GET.get("page_size")
    try:
        page_size = int(page_size)
    except (TypeError ,ValueError):
        page_size = 3

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
    }
    return render(request, 'shop/products-grid.html', data)


def product_detail(request, slug):
    products = get_object_or_404(Product, status=StatusType.publish, slug=slug)

    data = {
        'products': products,
    }
    return render(request, 'shop/products-detail.html', data)
