from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^signin', views.signInUser),
    url(r'^signup', views.signUpUser),
    url(r'^location/(?P<locationId>[0-9]+)$', views.getLocation),
    url(r'^location$', views.postLocation),
    url(r'^locations$', views.getAllLocations),
]
