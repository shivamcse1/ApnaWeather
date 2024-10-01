import 'package:apna_weather_app/core/routes/app_routes.dart';
import 'package:apna_weather_app/data/local_database/shared_preference/shared_preference_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Global Navigator key (used when you want to navigate without context)
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late SharedPreferences localDb;
final RouteObserver routeObserver = RouteObserver();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDataBaseHelper().init();
  
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
        navigatorObservers: [routeObserver],
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        // home:const MapScreen(),
        initialRoute: AppRoutes.splashScreen,
        routes: AppRoutes.routes,
       );
      },
    );
  }
}

