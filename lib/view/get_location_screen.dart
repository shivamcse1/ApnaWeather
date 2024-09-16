import 'package:apna_weather_app/utils/uihelper/get_current_location.dart';
import 'package:flutter/material.dart';


class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  bool isLoading=false;
  double lat = 0;
  double lang = 0;
  String address = '';
  GetCurrentLocation getCurrentLocation = GetCurrentLocation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text("location"),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator(),)
      
       :Center(
        child: Column(
    
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
             Text("Latitude :${getCurrentLocation.lat} ",style: const TextStyle(fontSize: 22)),
             Text("Longitude :${getCurrentLocation.lang} ",style: const TextStyle(fontSize: 22)),
             Text("Address :${getCurrentLocation.Address} ",style: const TextStyle(fontSize: 22)),
             Image.asset("assets/images/cloudy.gif",),
            ElevatedButton(
              onPressed: () async {
                isLoading=true;
                await getCurrentLocation.checkDeviceLocationPermission();
                setState(() {
                  isLoading=false;
                });
              },
              child: const Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }

   

}
