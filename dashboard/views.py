from django.contrib.auth.decorators import login_required
from django.shortcuts import redirect
from accounts.models import UserType


@login_required(login_url='accounts:login')
def dashboard_home(request):
    if request.user.type == UserType.customer.value:
        return redirect('dashboard:customer:home')

    if request.user.type == UserType.admin.value:
        return redirect('dashboard:admin:home')

    if request.user.type == UserType.superuser.value:
        return redirect('dashboard:admin:home')

    return redirect('accounts:login')
