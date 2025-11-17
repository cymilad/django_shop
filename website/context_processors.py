from footer.models import SocialMedia, Footer_text

def global_footer_data(request):
    try:
        social_media = SocialMedia.objects.get(id=1)
    except SocialMedia.DoesNotExist:
        social_media = None

    try:
        footer_text = Footer_text.objects.get(id=1)
    except Footer_text.DoesNotExist:
        footer_text = None

    return {
        'social_media': social_media,
        'footer_text': footer_text,
    }