import 'dart:async';
import 'package:apna_weather_app/core/constants/image_const.dart';
import 'package:apna_weather_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // Todo:
    super.initState();

    Timer(const Duration(seconds: 5),()
    {
     Navigator.pushReplacementNamed(context,AppRoutes.bottomNavScreen );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 174, 84, 192),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          
          children: [

           const SizedBox(height: 250,),
            Center(
              child: Image.asset(ImageConst.splashImg,
              height: 200,
              ),
            ),
           const SizedBox(height: 5,),

           RichText(
              text: const TextSpan(
                text: "A",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.3,
      
                  ),
              
               children: [
                TextSpan(
                  text: "pna",
                  style: TextStyle(color: Colors.white,fontSize: 28),

                ),

                TextSpan(
                text: " W",
                style: TextStyle(color: Colors.pink,fontSize: 30),
                ),
                  TextSpan(
                  text: "eather",
                  style: TextStyle(color: Colors.white,fontSize: 28),

                ),
               ]
              ),
              ),
             
             const SizedBox(height: 2),
             const SizedBox(
                width: 180,
                  child: LinearProgressIndicator(
                  
                    backgroundColor: Colors.white,
                    color: Colors.pink,
                ),
                )
          ],
        ),
      ),
    );
  }
}