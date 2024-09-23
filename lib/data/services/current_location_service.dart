import 'package:apna_weather_app/utils/uihelper/toast_message_helper.dart';
import 'package:geolocator/geolocator.dart';

class LocationService{

  static Future<Map<String,double>> getCurrentLocation() async{
    Map<String,double> latLongMap={};
    double long=0;
    double lat=0;
     // check device location enable or not 
    bool serviceEnable ;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      Toasthelper.showFlutterToast("Please Turn On Location");
       await Geolocator.openLocationSettings();
       return latLongMap;
    }
    
    //if enable then proceed 
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
         
        Toasthelper.showFlutterToast("Denied Location Permisison!");
        LocationPermission askAgain = await Geolocator.requestPermission();
        if(askAgain==LocationPermission.denied || askAgain==LocationPermission.deniedForever ){
          Toasthelper.showFlutterToast("Location Permisison Denied Forever!");
          return latLongMap;
        }
        else{
           Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            long=position.longitude;
            lat= position.latitude;

            latLongMap={
            "latitude":lat,
            "longitude":long
            };
            return latLongMap;
        }
    }
    else if(permission ==LocationPermission.deniedForever){
      Toasthelper.showFlutterToast("Location Permisison Denied Forever!");
      return latLongMap;
    }
    else{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      long=position.longitude;
      lat= position.latitude;

      latLongMap={
     "latitude":lat,
     "longitude":long
     };
    }
   return latLongMap;

  }
}