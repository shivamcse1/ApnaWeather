import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title:const Text("Map"),
      ),
      body: Container(
        height: 500,
        child: Text("Gogole Map")
    ));
  }
}