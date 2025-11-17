from django.db import models


# Social Media
class SocialMedia(models.Model):
    telegram = models.URLField(null=True, blank=True)
    youtube = models.URLField(null=True, blank=True)
    instagram = models.URLField(null=True, blank=True)
    github = models.URLField(null=True, blank=True)
    linkden = models.URLField(null=True, blank=True)

    def __str__(self):
        return 'شبکه های اجتماعی'


class Footer_text(models.Model):
    address = models.CharField(null=True, blank=True, max_length=100)
    phone_number = models.CharField(null=True, blank=True, max_length=12)
    text_footer = models.CharField(null=True, blank=True, max_length=100)

    def __str__(self):
        return self.phone_number
