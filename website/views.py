from django.shortcuts import render
from shop.models import *


def index(request):
    last_products = Product.objects.filter(
        status=StatusType.publish.value).distinct().order_by("-created_date")[:8]

    wishlist_items = []
    if request.user.is_authenticated:
        wishlist_items = Wishlist.objects.filter(
            user=request.user).values_list("product__id", flat=True)

    data = {
        'last_products': last_products,
        'wishlist_items': wishlist_items,
    }
    return render(request, 'website/index.html', data)


def contact(request):
    data = {}
    return render(request, 'website/contact.html', data)


def about(request):
    data = {}
    return render(request, 'website/about.html', data)
