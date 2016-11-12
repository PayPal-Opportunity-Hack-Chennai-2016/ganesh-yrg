from django.db import models

class UserProfile(models.Model):
  name = models.CharField(max_length=30)
  address = models.CharField(max_length=250)
  email = models.EmailField(max_length=100, null=True, blank=True, unique=True)
  mobile = models.CharField(max_length=30)
  password = models.CharField(max_length=30)
