from shop.models import *
from .models import Cart, CartItem


class CartSession:
    def __init__(self, session):
        self.session = session
        self.cart = self.session.setdefault("cart", {
            "items": [],
            "total_price": 0,
            "total_items": 0,
        })

    def update_product_quantity(self, product_id, quantity):
        for item in self.cart["items"]:
            if product_id == item["product_id"]:
                item["quantity"] = int(quantity)
                break
        else:
            return
        self.save()

    def remove_product(self, product_id):
        for item in self.cart["items"]:
            if product_id == item["product_id"]:
                self.cart["items"].remove(item)
                break
        else:
            return
        self.save()

    def add_product(self, product_id):
        for item in self.cart["items"]:
            if product_id == item["product_id"]:
                item["quantity"] += 1
                break
        else:
            new_item = {
                "product_id": product_id,
                "quantity": 1,
            }
            self.cart["items"].append(new_item)
        self.save()

    def clear(self):
        self.cart = self.session["cart"] = {
            "items": [],
            "total_price": 0,
            "total_items": 0,
        }
        self.save()

    def get_cart_dict(self):
        return self.cart

    def get_cart_items(self):
        for item in self.cart["items"]:
            product = Product.objects.get(id=item["product_id"], status=StatusType.publish)
            item.update({
                "product": product,
                "total_price": item["quantity"] * product.get_price(),
            })
        return self.cart["items"]

    def get_total_payment_amount(self):
        return sum(item["total_price"] for item in self.cart["items"])

    def get_total_quantity(self):
        total_quantity = 0
        for item in self.cart["items"]:
            total_quantity += item["quantity"]
        return total_quantity

    def save(self):
        self.session.modified = True

    def sync_cart_itmes_from_db(self, user):
        cart, created = Cart.objects.get_or_create(user=user)
        cart_items = CartItem.objects.filter(cart=cart)

        for cart_item in cart_items:
            for item in self.cart["items"]:
                if str(cart_item.product.id) == item["product_id"]:
                    cart_item.quantity = item["quantity"]
                    cart_item.save()
                    break
            else:
                new_item = {
                    "product_id": str(cart_item.product.id),
                    "quantity": cart_item.quantity,
                }
                self.cart["items"].append(new_item)
        self.merge_session_cart_in_db(user)
        self.save()

    def merge_session_cart_in_db(self, user):
        cart, created = Cart.objects.get_or_create(user=user)

        for item in self.cart["items"]:
            product_obj = Product.objects.get(id=item["product_id"], status=StatusType.publish.value)

            cart_item, created = CartItem.objects.get_or_create(cart=cart, product=product_obj)
            cart_item.quantity = item["quantity"]
            cart_item.save()
        session_product_ids = [item["product_id"] for item in self.cart["items"]]
        CartItem.objects.filter(cart=cart).exclude(product__id__in=session_product_ids).delete()