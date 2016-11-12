from django.conf.urls import url

from . import views
app_name = 'EcoKitchen'

urlpatterns = [
    url(r'^signin', views.signInUser),
    url(r'^signup', views.signUpUser),
    url(r'^location/(?P<locationId>[0-9]+)$', views.getLocation),
    url(r'^location$', views.postLocation),
    url(r'^locations$', views.getAllLocations),
    url(r'^feedback$', views.addFeedback),
    url(r'^userspage/$', views.userspage, name='userspage'),
    url(r'^locationspage/$', views.locationspage, name='locationspage'),
    url(r'^feedbackpage/$', views.feedbackpage, name='feedbackpage'),
    url(r'^locationdetail/(?P<location_id>[0-9]+)/$', views.locationdetail, name='locationdetail'),
    url(r'^userdetail/(?P<user_id>[0-9]+)/$', views.userdetail, name='userdetail'),    
    url(r'^entrepreneurs/$', views.entrepreneurs, name='entrepreneurs'),
]
