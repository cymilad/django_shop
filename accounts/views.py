from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.core.signing import TimestampSigner, BadSignature, SignatureExpired
from django.contrib import messages
from django.core.mail import send_mail
from django.urls import reverse
from django.conf import settings
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
            messages.success(request, 'اکانت شما با موفقیت فعال شد. اکنون می‌توانید وارد شوید.')
            print('Your account has been successfully activated. You can now log in.')
        else:
            messages.info(request, 'اکانت شما قبلاً فعال شده بود.')
            print('Your account was already activated.')
        return redirect('accounts:login')  # Redirect login page
    except (BadSignature, SignatureExpired, User.DoesNotExist):
        messages.error(request, 'لینک فعالسازی نامعتبر یا منقضی شده است')
        print('The activation link is invalid or expired.')
        return redirect('accounts:login')


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
            print('successfully logged in.')
            return redirect('website:index')
        else:
            messages.error(request, "ایمیل یا رمز عبور اشتباه است.")

    return render(request, 'accounts/login.html')


def logout_user(request):
    logout(request)
    messages.success(request, "شما با موفقیت خارج شدید.")
    return redirect("accounts:login")


def signup_user(request):
    if request.method == 'POST':
        email = request.POST.get('email', '').strip()
        password = request.POST.get('password', '').strip()
        confirm_password = request.POST.get('confirm_password', '').strip()
        firstname = request.POST.get('firstname')
        lastname = request.POST.get('lastname')
        phonenumber = request.POST.get('phonenumber', '').strip()

        form_data = {
            'email': email,
            'firstname': firstname,
            'lastname': lastname,
            'phonenumber': phonenumber
        }

        # validators
        if not all([email, password, confirm_password, firstname, lastname, phonenumber]):
            messages.error(request, "لطفاً همه فیلدها را پر کنید.")
            return render(request, 'accounts/signup.html', {'form_data': form_data})

        if len(password) < 8:
            messages.error(request, 'رمز عبور باید حداقل ۸ کاراکتر باشد.')
            return render(request, 'accounts/signup.html', {'form_data': form_data})

        if password != confirm_password:
            messages.error(request, 'رمز عبور و تکرار با هم مطابقت ندارد')
            return render(request, 'accounts/signup.html', {'form_data': form_data})

        if User.objects.filter(email=email).exists():
            messages.error(request, 'این ایمیل قبلاً ثبت شده است')
            return render(request, 'accounts/signup.html', {'form_data': form_data})

        # make user disable_active
        user = User.objects.create_user(email=email, password=password)

        # complate Profile user
        profile = user.user_profile
        profile.first_name = firstname
        profile.last_name = lastname
        profile.phone_number = phonenumber
        profile.save()

        # send email active user
        signer = TimestampSigner()
        token = signer.sign(user.pk)
        activation_link = f"{settings.SITE_URL}{reverse('accounts:activate-account', kwargs={'token': token})}"

        subject = 'فعالسازی حساب کاربری'
        message = f"سلام {firstname}\nبرای فعالسازی حساب خود روی لینک زیر کلیک کنید:\n{activation_link}"
        send_mail(subject, message, settings.DEFAULT_FROM_EMAIL, [email])

        messages.success(request, 'ثبت ‌نام انجام شد. لطفاً ایمیل خود را برای فعالسازی بررسی کنید.')
        return redirect('accounts:signup')

    return render(request, 'accounts/signup.html')


def reset_password_user(request):
    return render(request, 'accounts/reset_password.html')

def password_reset_confirm(request, token):
    return render(request, 'accounts/reset_password_confirm.html')
