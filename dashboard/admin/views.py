from django.shortcuts import render
from django.http import HttpResponseForbidden
from django.contrib.auth.decorators import login_required
from functools import wraps
from accounts.models import UserType


def admin_required(view_func):
    @wraps(view_func)
    @login_required(login_url='accounts:login')
    def warapped_view(request, *args, **kwargs):
        if request.user.type != UserType.superuser.value and request.user.type != UserType.admin.value:
            return HttpResponseForbidden("شما دسترسی ادمین ندارید")
        return view_func(request, *args, **kwargs)

    return warapped_view


@admin_required
def admin_dashboard_home(request):
    data = {}
    return render(request, 'dashboard/admin/home.html', data)
