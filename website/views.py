from django.shortcuts import render
from shop.models import *


def index(request):
    last_products = Product.objects.filter(status=StatusType.publish.value).order_by("-created_date")[:8]

    data = {
        'last_products': last_products,
    }
    return render(request, 'website/index.html', data)


def contact(request):
    data = {}
    return render(request, 'website/contact.html', data)


def about(request):
    data = {}
    return render(request, 'website/about.html', data)
