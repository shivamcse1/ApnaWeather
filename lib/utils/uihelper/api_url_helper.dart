import 'package:apna_weather_app/core/constants/api_url_const.dart';

class WeatherHelper{
 
  static Map<String,String> getUrlByCityName ({required String cityName}){
    return {
        // ignore: prefer_interpolation_to_compose_strings
        'forecast': ApiUrlConst.forecastUrl+"q=$cityName&appid=${ApiUrlConst.apiKey}",
        
        // ignore: prefer_interpolation_to_compose_strings
        'currentWeather' : ApiUrlConst.weatherUrl+"q=$cityName&appid=${ApiUrlConst.apiKey}", 
    };
  }

  static Map<String,String> getUrlByLatLong ({required double lat, required double long}){

    return {
      // ignore: prefer_interpolation_to_compose_strings
      "currentWeather" : ApiUrlConst.weatherUrl+"lat=$lat&lon=$long&appid=${ApiUrlConst.apiKey}",
      
      // ignore: prefer_interpolation_to_compose_strings
      "forecast" :ApiUrlConst.forecastUrl+"lat=$lat&lon=$long&appid=${ApiUrlConst.apiKey}",

    };
  }

}