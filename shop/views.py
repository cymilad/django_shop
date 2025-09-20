from django.shortcuts import render
from .models import *


def index(request):
    products = Product.objects.filter(status=StatusType.publish)

    data = {
        'products': products,
    }
    return render(request, 'shop/products-grid.html', data)
