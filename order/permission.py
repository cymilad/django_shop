from django.contrib.auth.decorators import login_required
from django.http import HttpResponseForbidden
from functools import wraps
from accounts.models import UserType

def customer_required(view_func):
    @wraps(view_func)
    @login_required(login_url='accounts:login')
    def _wrapped_view(request, *args, **kwargs):
        if request.user.type != UserType.customer.value:
            return HttpResponseForbidden("شما دسترسی مشتری ندارید")
        return view_func(request, *args, **kwargs)

    return _wrapped_view