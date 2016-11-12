from django.shortcuts import render
from django.http import HttpResponse
from django.http import JsonResponse
from rest_framework.decorators import parser_classes
from rest_framework.parsers import JSONParser
from EcoKitchen.models import UserProfile
from django.core.exceptions import ObjectDoesNotExist
from django.core.exceptions import MultipleObjectsReturned
import logging

from rest_framework.decorators import api_view
from rest_framework.response import Response

logging.basicConfig()
logger = logging.getLogger(__name__)
# Create your views here.
def post_list(self, *args, **kwargs):
  return HttpResponse('{"success":"true"}')

@api_view(['GET', 'POST'])
@parser_classes((JSONParser,))
def signInUser(request):
  logger.critical(request.method)
  logger.critical("DATA :: " + request.body)
  result = True;
  msg = None;

  if request.method == 'POST' and request.content_type == 'application/json' :
    mobile = request.data['mobile']
    password = request.data['password']
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

    response_data = {}
    response_data['success'] = result
    response_data['message'] = msg
  return JsonResponse(response_data)