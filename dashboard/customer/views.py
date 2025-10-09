from django.shortcuts import render
from django.urls import reverse_lazy
from django.contrib.auth.decorators import login_required


@login_required(login_url=reverse_lazy('accounts:login'))
def customer_dashboard_home(request):
    data = {}
    return render(request, 'dashboard/customer/home.html', data)
