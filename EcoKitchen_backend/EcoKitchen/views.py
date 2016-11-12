from django.shortcuts import render
from django.http import HttpResponse
from django.http import JsonResponse
from rest_framework.decorators import parser_classes
from rest_framework.parsers import JSONParser
from EcoKitchen.models import UserProfile
from django.core.exceptions import ObjectDoesNotExist
from django.core.exceptions import MultipleObjectsReturned
from django.db.models import Q
import logging

from rest_framework.decorators import api_view
from rest_framework.response import Response

logging.basicConfig()
logger = logging.getLogger(__name__)

UserProfile_NAME = "name"
UserProfile_PASSWORD = "password"
UserProfile_EMAIL = "email"
UserProfile_ADDRESS = "address"
UserProfile_MOBILE = "mobile"
# Create your views here.
def post_list(self, *args, **kwargs):
  return HttpResponse('{"success":"true"}')

@api_view(['POST'])
@parser_classes((JSONParser,))
def signInUser(request):
  logger.critical(request.method)
  logger.critical("DATA :: " + request.body)
  result = True;
  msg = None;

  if request.method == 'POST' and request.content_type == 'application/json' :
    mobile = request.data[UserProfile_MOBILE]
    password = request.data[UserProfile_PASSWORD]
    try :
        UserProfile.objects.get(mobile=mobile, password=password)
    except ObjectDoesNotExist:
        logger.critical("User did not exist")
        result = False
        msg = "User did not exist"
    except MultipleObjectsReturned:
        logger.critical("Multiple objects returned")
        msg = "Multiple objects returned"
        result = False
  else:
    msg = "Unknown ContentType or Method Name"
    result = False

    response_data = {}
    response_data['success'] = result
    response_data['message'] = msg
  return JsonResponse(response_data)

@api_view(['POST'])
@parser_classes((JSONParser,))
def signUpUser(request):
    logger.critical("DATA :: " + request.body)

    result = True
    msg = None
    if request.method == 'POST' and request.content_type == 'application/json' :
        name = request.data[UserProfile_NAME]
        password = request.data[UserProfile_PASSWORD]
        email = request.data[UserProfile_EMAIL]
        address = request.data[UserProfile_ADDRESS]
        mobile = request.data[UserProfile_MOBILE]
        try:
            existingUser = UserProfile.objects.filter(Q(email=email)|Q(mobile=mobile))
            if existingUser != None and existingUser.count() > 0:
                result = False
                msg = "A user is present with same email or mobile number"
            else:
                userProfile = UserProfile(name=name, password=password,
                                  email=email, address=address, mobile=mobile)
                userProfile.save()
        except Exception:
            logger.critical("Cannot insert succesfully")
            result = False
            msg = "DB insertion error"
    else:
        result = False
        msg = "Unknown ContentType or Method"

    response_data = {}
    response_data['success'] = result
    response_data['message'] = msg
    return JsonResponse(response_data)