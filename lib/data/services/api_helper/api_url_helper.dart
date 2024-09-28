// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:apna_weather_app/core/constants/api_url_const.dart';

class ApiUrlHelper{
 
  static Map<String,String> getWeatherUrlByCityName ({required String cityName}){
    return {
        'forecast': ApiUrlConst.forecastUrl+"q=$cityName&appid=${ApiUrlConst.apiKey}",
        'currentWeather' : ApiUrlConst.weatherUrl+"q=$cityName&appid=${ApiUrlConst.apiKey}", 
    };
  }

  static Map<String,String> getWeatherUrlByLatLong ({required double lat, required double long}){
    return {
      "currentWeather" : ApiUrlConst.weatherUrl+"lat=$lat&lon=$long&appid=${ApiUrlConst.apiKey}",
      "forecast" :ApiUrlConst.forecastUrl+"lat=$lat&lon=$long&appid=${ApiUrlConst.apiKey}",
    };
  }
  
  static String getSuggestPlaceUrl({required String placeName}){
   return "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=${ApiUrlConst.apikey1}"; 
  }
  static String getLaLongUrlByPlaceId({required String placeId}){
   return "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${ApiUrlConst.apikey1}"; 
  }
}