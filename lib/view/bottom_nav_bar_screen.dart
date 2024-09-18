import 'package:apna_weather_app/view/weather_screen/weather_screen.dart';
import 'package:apna_weather_app/view/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

import 'add_city_screen/add_city_screen.dart';
import 'location_screen/location_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => BottomNavBarScreenState();
}

class BottomNavBarScreenState extends State<BottomNavBarScreen> {
 int selectedIndex =0;
 List bottomNavBarScreen =[
   const AddCityScreen(),
   const WeatherScreen(),
   const ProfileScreen()
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bottomNavBarScreen[selectedIndex] ,

        bottomNavigationBar:  BottomNavigationBar(
        selectedIconTheme: const IconThemeData(
        color: Colors.blue,
        ),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white,
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        currentIndex: selectedIndex,
        onTap: (tapIndex) {
          setState(() {
            selectedIndex=tapIndex;
          });
        },
        elevation: 10,
        backgroundColor:const Color.fromARGB(255, 104, 71, 142),
        type: BottomNavigationBarType.fixed,
        items: const [

          BottomNavigationBarItem(
          icon: Icon(Icons.add_location_alt,color: Colors.white,),
          label: "Add Location"
          ),
        
          BottomNavigationBarItem(
          icon: Icon(Icons.cloud,color: Colors.white,),
          label: "Weather"
          ),

          BottomNavigationBarItem(
          icon: Icon(Icons.manage_accounts,color: Colors.white,),
          label: "Account"
          ),
          ]
        ),
    );
  }
}