from django.shortcuts import render
from django.urls import reverse_lazy
from django.contrib.auth.decorators import login_required


@login_required(login_url=reverse_lazy('accounts:login'))
def admin_dashboard_home(request):
    data = {}
    return render(request, 'dashboard/admin/home.html', data)
