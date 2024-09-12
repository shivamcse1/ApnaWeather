import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LatLongScreen extends StatefulWidget {
  const LatLongScreen({super.key});

  @override
  State<LatLongScreen> createState() => LatLongScreenState();
}

class LatLongScreenState extends State<LatLongScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("location"),
      ),
      body: ElevatedButton(
        
        onPressed: () async{
           await getLocation();
        },
        child: Text("Get Location"),),
    );
  }

  getLocation() async {

    LocationPermission permission = await Geolocator.checkPermission();
    if(permission== LocationPermission.denied || permission== LocationPermission.deniedForever){

       print("location denied");

       LocationPermission askpermission = await Geolocator.requestPermission();
    }
    else{

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("lattitude:${position.latitude.toString()}");
      print("lattitude:${position.longitude.toString()}");
    }
    
  }
}