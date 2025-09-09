from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.core.signing import TimestampSigner, BadSignature, SignatureExpired
from django.contrib import messages
from .models import User


def activate_account(request, token):
    signer = TimestampSigner()
    try:
        user_pk = signer.unsign(token, max_age=60 * 60 * 24)  # The link is valid for 24 hours.
        user = User.objects.get(pk=user_pk)
        if not user.is_verified:
            user.is_verified = True
            user.is_active = True  # Activate after email confirmation.
            user.save()
            messages.success(request, 'اکانت شما با موفقیت فعال شد! حالا می‌توانید وارد شوید.')
            print('Your account has been successfully activated. You can now log in.')
        else:
            messages.info(request, 'اکانت شما قبلاً فعال شده بود.')
            print('Your account was already activated.')
        return redirect('website:index')  # Redirect Home page
    except (BadSignature, SignatureExpired, User.DoesNotExist):
        messages.error(request, 'لینک فعالسازی نامعتبر یا منقضی شده است')
        print('The activation link is invalid or expired.')
        return redirect('website:index')


def login_user(request):
    if request.user.is_authenticated:
        return redirect('website:index')

    if request.method == 'POST':
        username = request.POST.get('username', '').strip()
        password = request.POST.get('password', '').strip()

        if not username or not password:
            messages.error(request, "ایمیل و رمزعبور را وارد کنید.")
            return redirect("accounts:login")

        if len(password) < 8:
            messages.error(request, "رمزعبور باید حداقل 8 کاراکتر باشد.")
            return redirect("accounts:login")

        user = authenticate(request, username=username, password=password)

        if user is not None:
            login(request, user)
            messages.success(request, 'با موفقیت وارد شدید.')
            return redirect('website:index')
        else:
            messages.error(request, "ایمیل یا رمزعبور اشتباه است.")

    return render(request, 'accounts/login.html')


def logout_user(request):
    logout(request)
    messages.success(request, "با موفقیت خارج شدید")
    return redirect("accounts:login")
