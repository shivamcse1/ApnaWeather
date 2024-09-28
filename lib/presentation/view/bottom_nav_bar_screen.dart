import 'package:apna_weather_app/presentation/view/search_screen/search_screen.dart';
import 'package:apna_weather_app/presentation/view/weather_screen/weather_screen.dart';
import 'package:flutter/material.dart';

import 'add_city_screen/add_city_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => BottomNavBarScreenState();
}

class BottomNavBarScreenState extends State<BottomNavBarScreen> {
 int selectedIndex =0;
 List bottomNavBarScreen =[
   const AddCityScreen(),
   const SearchScreen(),
   const WeatherScreen(),
  //  const ProfileScreen()
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bottomNavBarScreen[selectedIndex] ,

        bottomNavigationBar:  BottomNavigationBar(

        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white,
        unselectedLabelStyle: const TextStyle(fontSize: 15),
        selectedLabelStyle: const TextStyle(fontSize: 15),
        
        
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
          label: "Add City"
          ),

          BottomNavigationBarItem(
          icon: Icon(Icons.search,color: Colors.white,),
          label: "Search"
          ),
        
          BottomNavigationBarItem(
          icon: Icon(Icons.cloud,color: Colors.white,),
          label: "Weather"
          ),

          // BottomNavigationBarItem(
          // icon: Icon(Icons.manage_accounts,color: Colors.white,),
          // label: "Account"
          // ),
          ]
        ),
    );
  }
}