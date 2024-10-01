import 'package:apna_weather_app/presentation/view/add_city_screen/add_city_screen.dart';
import 'package:apna_weather_app/presentation/view/bottom_nav_bar_screen.dart';
import 'package:apna_weather_app/presentation/view/forecast_screen/forecast_screen.dart';
import 'package:apna_weather_app/presentation/view/login_screen.dart';
import 'package:apna_weather_app/presentation/view/no_data_found_screen.dart/no_data_found_screen.dart';
import 'package:apna_weather_app/presentation/view/profile_screen/profile_screen.dart';
import 'package:apna_weather_app/presentation/view/add_city_screen/add_city_search_screen.dart';
import 'package:apna_weather_app/presentation/view/splash_screen.dart';
import 'package:apna_weather_app/presentation/view/weather_screen/weather_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes{

  // App Screen Name
  static const String splashScreen = '/';
  static const String bottomNavScreen = '/bottomNavScreen';
  static const String loginScreen = '/loginScreen';
  static const String forecastScreen = '/forecastScreen';
  static const String weatherScreen = '/weatherScreen';
  static const String profileScreen = 'profileScreen';
  static const String addCityScreen = '/addCityScreen';
  static const String searchScreen = '/searchScreen';
  static const String noInternetScreen ='/noInternetScreen';


  // Simpler Routing Approach mostly used for normal to medium  less complex level project

  static final Map<String,WidgetBuilder> routes =
     {
      '/':(context) => const SplashScreen(),
      '/bottomNavScreen' : (context)=> const BottomNavBarScreen(),
      '/loginScreen' :(context)=> const LoginScreen(),
      '/addCityScreen' :(context)=> const AddCityScreen(),
      '/forecastScreen' :(context)=> const ForecastScreen(),
      '/profileScreen':(context)=> const ProfileScreen(),
      '/weatherScreen' :(context)=> const WeatherScreen(),
      '/searchScreen' :(context)=> const SearchScreen(),
      '/noInternetScreen' :(context) => const NoInternetScreen(),
    };
  
  // Dynamic Routing Approach mostly used for normal to very complex level project
  
  // we can use any of them but we can use first because all things can be handle 
  
  // static Route<dynamic> generateRoute (RouteSettings setting){

  //   switch(setting.name){

  //     case bottomNavScreen:
  //     return MaterialPageRoute(builder: (context) =>const BottomNavBarScreen());

  //     case splashScreen:
  //     return MaterialPageRoute(builder: (context) =>const SplashScreen());

  //     case loginScreen:
  //     return MaterialPageRoute(builder: (context) =>const LoginScreen());

  //     case forecastScreen:
  //     return MaterialPageRoute(builder: (context) =>const ForecastScreen());

  //     case weatherScreen:
  //     return MaterialPageRoute(builder: (context) =>const WeatherScreen());

  //     case profileScreen:
  //     return MaterialPageRoute(builder: (context) =>const ProfileScreen());

  //     case addCityScreen:
  //     return MaterialPageRoute(builder: (context) =>const AddCityScreen());

  //     case searchScreen:
  //     return MaterialPageRoute(builder: (context) =>const SearchScreen());

  //     default :
      
  //     return MaterialPageRoute(builder: (context) {

  //       return const Scaffold(
  //         body: Text("no route defined"),
  //       );
  //      }); 
  //   }
  // }

}