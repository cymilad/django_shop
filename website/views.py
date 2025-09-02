from django.shortcuts import render


def index(request):
    data = {}
    return render(request, 'website/index.html', data)


def contact(request):
    data = {}
    return render(request, 'website/contact.html', data)


def about(request):
    data = {}
    return render(request, 'website/about.html', data)
