// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:apna_weather_app/core/constants/database_key_const.dart';
import 'package:apna_weather_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataBaseHelper {
 
 Future init() async{
   localDb = await SharedPreferences.getInstance();
   }
 
 //------------create or insert data in the local Storage-------------//
  void setData({required  String weatherData}){
   
      var cityWeatherdata = getData();
      if(cityWeatherdata == null){
        cityWeatherdata = [];
        cityWeatherdata.add(weatherData);
        localDb.setStringList(DatabaseKeyConst.cityData,cityWeatherdata);
      }
      else{
        cityWeatherdata.add(weatherData);
        localDb.setStringList(DatabaseKeyConst.cityData,cityWeatherdata);
      }
  }
 

  //------------Read data from local Storage-------------//
   List<String>? getData () {
   return (localDb.getStringList(DatabaseKeyConst.cityData));
   }

  //------------ Update Data in Local storage ------------//
  void updateData ({required String keyValue,required List<dynamic>dataList }){
     List<String> updateList = dataList.map((mapData) {
          return jsonEncode(mapData);
     }).toList();
     localDb.setStringList(keyValue,updateList);
  }

  //------------ Delete Data in Local storage ------------//
  void deleteData (String keyValue) {
    localDb.remove(keyValue);
  }

   //------------Clear whole Data in Local storage ------------//
  void deleteAllData () async{
    await localDb.clear();
  }



  static Map<String,dynamic> databaseHelper( {required Map<String,dynamic> data}){
    
    Map<String,dynamic> localDatabaseMap={};
    String cityName = data["name"][0].toUpperCase()+data["name"].substring(1);
    localDatabaseMap ={
      DatabaseKeyConst.mainTemp : (data["main"]["temp"]-273.15).toStringAsFixed(1),
      DatabaseKeyConst.minTemp :(data["main"]["temp_min"]-273.15).toStringAsFixed(2),
      DatabaseKeyConst.maxTemp :(data["main"]["temp_max"]-273.15).toStringAsFixed(1),
      DatabaseKeyConst.feelLikeTemp :(data["main"]["feels_like"]-273.15).toStringAsFixed(1),
      DatabaseKeyConst.cloudiness :data["clouds"]["all"],
      DatabaseKeyConst.cityName : cityName.length <=13? cityName : cityName.substring(0,18)+'..',
      DatabaseKeyConst.countryName : data["sys"]["country"],
      DatabaseKeyConst.skyCondition:data["weather"][0]["main"]
      };
      return localDatabaseMap;
  }
}