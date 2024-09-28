import 'dart:convert';

import 'package:apna_weather_app/core/routes/app_routes.dart';
import 'package:apna_weather_app/main.dart';
import 'package:apna_weather_app/utils/uihelper/toast_message_helper.dart';
import 'package:http/http.dart';

class ResponseHelper{

  static dynamic returnResponse({required Response response}){
     
     switch(response.statusCode){

      case 200:
      var responseJson = jsonDecode(response.body);
      return responseJson;
     
      case 201:
      var responseJson = jsonDecode(response.body);
      return responseJson;

      case 400:
      var decodeError = jsonDecode(response.body);
      if(decodeError.containesKey('error')){
        Toasthelper.showFlutterToast(decodeError['error'].toString());
      }
      throw Exception('Api Error Status Code 400');

      case 401:
      navigatorKey.currentState!.pushReplacementNamed(AppRoutes.loginScreen);
      throw Exception("UNAUTHORIZED ACCESS ERROR 401");

      case 404:
      var responseJson = jsonDecode(response.body);
      return responseJson;

      case 500:
      var responseJson = jsonDecode(response.body);
      return responseJson;


     }

  }
}