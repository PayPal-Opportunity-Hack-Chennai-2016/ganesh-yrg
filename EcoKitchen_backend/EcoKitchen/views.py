from django.shortcuts import render
from django.http import HttpResponse
import logging

from rest_framework.decorators import api_view
from rest_framework.response import Response

logging.basicConfig()
logger = logging.getLogger(__name__)
# Create your views here.
def post_list(self, *args, **kwargs):
  return HttpResponse('{"success":"true"}')

@api_view(['GET', 'POST'])
def signInUser(request):
  logger.critical(request.method)
  logger.critical("DATA :: " + request.body)
  return HttpResponse('{"success":"true"}')

