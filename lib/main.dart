import 'package:apna_weather_app/view/home_screen.dart';
import 'package:apna_weather_app/view/login_screen.dart';
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
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        ),
        home: const HomeScreen(),
       );
      },
    );
  }
}

