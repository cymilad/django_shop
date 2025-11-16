from django.urls import path
from .views import *

app_name = "review"

urlpatterns = [
    path('submit-review/', submit_review, name='submit_review'),
]
