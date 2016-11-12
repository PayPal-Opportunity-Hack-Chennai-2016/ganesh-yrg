import logging

from django.core.exceptions import MultipleObjectsReturned
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Q
from django.http import HttpResponse
from django.http import JsonResponse
from django.shortcuts import render, get_object_or_404
from rest_framework import serializers
from rest_framework.decorators import api_view
from rest_framework.decorators import parser_classes
from rest_framework.parsers import JSONParser

from EcoKitchen.models import UserProfile,Location,FeedBack,ReferredPerson

# Create your views here.

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

class LocationSerializer(serializers.Serializer):
    lat = serializers.CharField(max_length=30)
    long = serializers.CharField(max_length=30)
    address = serializers.CharField(max_length=200)
    description = serializers.CharField(max_length=50)
    status = serializers.BooleanField()

@api_view(['POST'])
@parser_classes((JSONParser,))
def signInUser(request):
  logger.critical(request.method)
  logger.critical("DATA :: " + request.body)
  result = True;
  msg = None;
  userProfile = None
  response_data = {}
  if request.method == 'POST' and request.content_type == 'application/json' :
    mobile = request.data[UserProfile_MOBILE]
    password = request.data[UserProfile_PASSWORD]
    try :
        userProfile = UserProfile.objects.get(mobile=mobile, password=password)
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

  response_data['success'] = result
  response_data['message'] = msg
  if result:
    response_data['userId'] = userProfile.id
  return JsonResponse(response_data)

@api_view(['POST'])
@parser_classes((JSONParser,))
def signUpUser(request):
    logger.critical("DATA :: " + request.body)

    result = True
    msg = None
    userProfile = None
    if request.method == 'POST' and request.content_type == 'application/json' :
        name = request.data[UserProfile_NAME]
        password = request.data[UserProfile_PASSWORD]
        email = request.data[UserProfile_EMAIL]
        address = request.data[UserProfile_ADDRESS]
        mobile = request.data[UserProfile_MOBILE]
        try:
            if len(email) > 0:
                existingUser = UserProfile.objects.filter(Q(email=email)|Q(mobile=mobile))
            else:
                existingUser = UserProfile.objects.filter(Q(mobile=mobile))
            if existingUser != None and existingUser.count() > 0:
                result = False
                msg = "A user is present with same email or mobile number"
            else:
                userProfile = UserProfile(name=name, password=password,
                                  email=email, address=address, mobile=mobile)
                userProfile.save()
        except Exception as e:
            logger.critical("Cannot insert succesfully")
            logger.critical(e)
            result = False
            msg = "DB insertion error"
    else:
        result = False
        msg = "Unknown ContentType or Method"

    response_data = {}
    response_data['success'] = result
    response_data['message'] = msg
    if result:
        response_data['userId'] = userProfile.id
    return JsonResponse(response_data)

def getLocation(request, locationId):
    logger.critical(request.method)
    logger.critical("DATA :: " + request.body)
    result = True
    msg = None
    location = None
    try :
        location = Location.objects.get(id=locationId)
    except ObjectDoesNotExist:
        logger.critical("Location does not exist")
        result = False
        msg = "Location does not exist"
    except MultipleObjectsReturned:
        logger.critical("Multiple objects returned")
        msg = "Multiple objects returned"
        result = False
    response_data = {}
    if result:
        response_data = {}
        response_data['status'] = location.status
        response_data['description'] = location.description
        response_data['address'] = location.address
        response_data['userId'] = location.user.id
        response_data['lat'] = location.lat
        response_data['long'] = location.long
        response_data['id'] = location.id
        return JsonResponse(response_data)
    else:
        response_data['success'] = False
        response_data['message'] = msg
    return JsonResponse(response_data)

@api_view(['POST'])
@parser_classes((JSONParser,))
def postLocation(request):
    result = True
    msg = None
    location = None
    if request.method == 'POST' and request.content_type == 'application/json' :
        description = request.data['description']
        address = request.data['address']
        userId = request.data['userId']
        lat = str(request.data['lat'])
        long = str(request.data['long'])
        status = False
        try:
            existingLocation = Location.objects.filter(Q(lat=lat) & Q(long=long))
            userReferenced = None
            if existingLocation != None and existingLocation.count() > 0:
                result = False
                msg = "A Location is present with same Latitude and Longitude"
            else:
                try :
                    userReferenced = UserProfile.objects.get(id=userId)
                except ObjectDoesNotExist:
                    result = False
                    msg = "A User Id specified for location doesn't exist"
                location = Location(lat=lat, long=long,
                          address=address, description=description, status=status, user=userReferenced)
                location.save()
        except Exception as ex:
            logger.critical("Cannot insert succesfully:" + str(ex))
            result = False
            msg = "DB insertion error"
    else:
        result = False
        msg = "Unknown ContentType or Method"

    response_data = {}
    response_data['success'] = result
    response_data['message'] = msg
    if result:
        response_data['locationId'] = location.id
    return JsonResponse(response_data)

@api_view(['GET', 'POST'])
@parser_classes((JSONParser,))
def getAllLocations(request):
    locationList = Location.objects.all()
    if locationList != None and locationList.count() > 0:
        locationJson = LocationSerializer(locationList, many=True)
        return JsonResponse(locationJson.data, safe=False)
    else:
        return JsonResponse({})

@api_view(['POST'])
@parser_classes((JSONParser,))
def addFeedback(request):
    result = True
    msg = None
    feedback = None
    if request.method == 'POST' and request.content_type == 'application/json' :
        content = request.data['content']
        locationId = request.data['locationId']
        userId = request.data['userId']
        courtesy = request.data['courtesy']
        cleanliness = request.data['cleanliness']
        qualityOfFood =  request.data['qualityOfFood']
        quantityOfFood =  request.data['quantityOfFood']
        foodTaste = request.data['foodTaste']
        try:
            existingLocations = Location.objects.filter(id=locationId)
            existingUsers = UserProfile.objects.filter(id=userId)
            if existingLocations != None and existingLocations.count() > 0 and existingUsers != None and existingUsers.count() > 0:
                location = existingLocations.first()
                user = existingUsers.first()
                feedback = FeedBack(content=content, user=user, location=location, courtesy= courtesy, qualityOfFood = qualityOfFood,
                                    quantityOfFood = quantityOfFood, foodTaste = foodTaste, cleanliness= cleanliness)
                feedback.save()
            else:
                result = False
                msg = "Invalid Location or User!"

        except Exception as ex:
            logger.critical("Cannot insert succesfully:" + str(ex))
            result = False
            msg = "DB insertion error"
    else:
        result = False
        msg = "Unknown ContentType or Method"

    response_data = {}
    response_data['success'] = result
    response_data['message'] = msg
    if result:
        response_data['feedbackId'] = feedback.id
    return JsonResponse(response_data)


def locationspage(request):

    locations_list = Location.objects.all()
    context = {'locations_list': locations_list}
    return render(request,'EcoKitchen/locations.html',context)

def userspage(request):

    users_list = UserProfile.objects.all()
    context = {'users_list': users_list}
    return render(request,'EcoKitchen/users.html',context)


def feedbackpage(request):

    feedback_list = FeedBack.objects.all()
    context = {'feedback_list': feedback_list}
    return render(request,'EcoKitchen/feedbackpage.html',context)


def entrepreneurs(request):

    entre_list = ReferredPerson.objects.all()
    context = {'entre_list': entre_list}
    return render(request,'EcoKitchen/entrepreneurs.html',context) 



def locationdetail(request, location_id):
    location = get_object_or_404(Location, pk=location_id)
    if(request.POST.get('subbtn')):
        inplist = request.POST.getlist('i_case')
        outlist = request.POST.getlist('o_case')

    return render(request, 'EcoKitchen/locationdetail.html', {'loc': location})

def userdetail(request, user_id):
   usr = get_object_or_404(UserProfile, pk=user_id)
   if(request.POST.get('subbtn')):
       inplist = request.POST.getlist('i_case')
       outlist = request.POST.getlist('o_case')
   return render(request, 'EcoKitchen/userdetail.html', {'usr': usr})
