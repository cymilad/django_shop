from django.shortcuts import render
from .permission import customer_required


# @customer_required
def checkout(request):
    data = {}
    return render(request, 'order/checkout.html', data)
