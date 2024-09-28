import 'dart:convert';
import 'dart:developer';

import 'package:apna_weather_app/data/services/api_helper/api_url_helper.dart';
import 'package:http/http.dart'as http;
class ApiServices{

 static Map<String,dynamic> currentWeatherData={};
  static Map<String,dynamic> forecastData={};

 //! for get suggestion Place using Place Name
 static Future<List>  getSuggestedPlace ({required String place}) async {
  late List allPlaces =[];
  try{
    Uri apiUrl = Uri.parse(ApiUrlHelper.getSuggestPlaceUrl(placeName: place));
    var response = await http.get(apiUrl);
    if(response.statusCode==200){
        var dataMap = jsonDecode(response.body);
        allPlaces = dataMap["predictions"];
        return allPlaces;
    }

    return allPlaces;
  }
  catch(e){
    Exception("Exception occured $e");
    return allPlaces;
  }
 }


 //! for Getting Latlong Using PlaceId
 static Future<Map<String,dynamic>> getLatLongByPlaceID({required String placeID}) async{
   Map<String,dynamic> data={};
  try{

    Uri apiUrl = Uri.parse( ApiUrlHelper.getLaLongUrlByPlaceId(placeId: placeID));
      var response = await http.get(apiUrl);
      if(response.statusCode==200){
          data = jsonDecode(response.body);
          return data;
      }
      else{
        return data;
      }
  }
  catch(e){
    print("Error Occured :$e");
    return data;
  }
 }


 //! GetWeather using Lat long or CityName
  Future<void> getCurrentWeather ({String? locationName, double? latitude, double? longitude } ) async {
    Map<String,String> urlMap={};
    locationName==null 
    ? urlMap = ApiUrlHelper.getWeatherUrlByLatLong(lat: latitude!, long: longitude!)
    : urlMap = ApiUrlHelper.getWeatherUrlByCityName(cityName:locationName);
  
    try{
       
        Uri weatherUriUrl = Uri.parse(urlMap['currentWeather']!);
        Uri forecastUriUrl = Uri.parse(urlMap['forecast']!);
        
        var weatherResponse = await http.get(weatherUriUrl);
        var forecastResponse = await http.get(forecastUriUrl);
        
        if(weatherResponse.statusCode==200 && forecastResponse.statusCode==200){
           currentWeatherData = jsonDecode(weatherResponse.body);
           forecastData = jsonDecode(forecastResponse.body);
          //  log('current weathr data----------$currentWeatherData');
          //  log('5 day forecast data----------$forecastData');

          //  countryName =", ${currentWeatherData["sys"]["country"]}";
        }
        else if(weatherResponse.statusCode==404 || forecastResponse.statusCode==404){
               currentWeatherData = jsonDecode(weatherResponse.body);
              
        }
    }
    catch(e){
      log("Error Occured : $e");
    }
  }

 

}