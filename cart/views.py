from django.views.decorators.http import require_POST
from django.shortcuts import render
from django.http import JsonResponse
from .cart import *


def CartIndex(request):
    cart = CartSession(request.session)
    cart_items = cart.get_cart_items()
    total_quantity = cart.get_total_quantity()
    total_payment_price = cart.get_total_payment_amount()

    data = {
        'cart': cart,
        'cart_items': cart_items,
        'total_quantity': total_quantity,
        'total_payment_price': total_payment_price,
    }
    return render(request, 'cart/cart.html', data)


@require_POST
def AddProduct(request):
    cart = CartSession(request.session)
    product_id = request.POST.get('product_id')

    if product_id and Product.objects.filter(id=product_id, status=StatusType.publish).exists():
        cart.add_product(product_id)

    if request.user.is_authenticated:
        cart.merge_session_cart_in_db(request.user)

    return JsonResponse({
        'cart': cart.get_cart_dict(),
        'total_quantity': cart.get_total_quantity()
    })


@require_POST
def UpdateProduct(request):
    cart = CartSession(request.session)
    product_id = request.POST.get('product_id')
    quantity = request.POST.get('quantity')

    if product_id and quantity:
        cart.update_product_quantity(product_id, quantity)

    if request.user.is_authenticated:
        cart.merge_session_cart_in_db(request.user)

    return JsonResponse({
        "cart": cart.get_cart_dict(),
        'total_quantity': cart.get_total_quantity()
    })


@require_POST
def RemoveProduct(request):
    cart = CartSession(request.session)
    product_id = request.POST.get("product_id")

    if product_id:
        cart.remove_product(product_id)

    if request.user.is_authenticated:
        cart.merge_session_cart_in_db(request.user)

    return JsonResponse({
        "cart": cart.get_cart_dict(),
        "total_quantity": cart.get_total_quantity()
    })