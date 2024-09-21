import 'package:apna_weather_app/routes/app_routes.dart';
import 'package:apna_weather_app/view/add_city_screen/add_city_screen.dart';
import 'package:apna_weather_app/view/bottom_nav_bar_screen.dart';
import 'package:apna_weather_app/view/forecast_screen/forecast_screen.dart';
import 'package:apna_weather_app/view/location_screen/location_screen.dart';
import 'package:apna_weather_app/view/login_screen.dart';
import 'package:apna_weather_app/view/profile_screen/profile_screen.dart';
import 'package:apna_weather_app/view/splash_screen.dart';
import 'package:apna_weather_app/view/weather_screen/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize:const Size(360 , 800),
      builder: (_ ,child){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.bottomNavScreen,
        routes: AppRoutes.routes,
       );
      },
    );
  }
}

