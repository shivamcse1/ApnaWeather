import 'package:apna_weather_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//Global Navigator key (used when you want to navigate without context)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.bottomNavScreen,
        routes: AppRoutes.routes,
       );
      },
    );
  }
}

