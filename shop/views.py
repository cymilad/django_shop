from django.shortcuts import render


def index(request):
    data = {}
    return render(request, 'shop/products-grid.html', data)
