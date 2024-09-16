import 'package:apna_weather_app/utils/uihelper/toast_message.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentLocation {

  double lat = 0;
  double lang = 0;
  String Address ='';


  //!---------- check Device Location Permission----------//
  Future<void> checkDeviceLocationPermission() async {

    //-------for checking device location service enabled or not ----------//
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    //----------if enabled then get location ----------------//
    await getLocation();
  }

  //!---------- Get Location ----------//
  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {

      //--- ask again for permission----------//

      LocationPermission askpermission = await Geolocator.requestPermission();

      if (askpermission == LocationPermission.denied) {
        Uihelper().showFlutterToast("Location Permission Denied");
        return;
      }
    } else if (permission == LocationPermission.deniedForever) {
      Uihelper().showFlutterToast("Location Permission Denied Forever");
      return;
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      

      lat = position.latitude;
      lang = position.longitude;


      //-------- get address using latitude and longitude-------------//
      List<Placemark> result = await placemarkFromCoordinates(lat, lang);
      Address = "${result[1].name},${result[1].thoroughfare},${result[1].subLocality},${result[1].locality},${result[1].administrativeArea},${result[1].postalCode},";

      // print(result[1]);

    }
  }


}