import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 104, 71, 142),
                Color.fromARGB(255, 146, 33, 140),
              ]),
        ),
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            
            Image.asset("assets/images/no_internet.webp"),
            Text("No Internet Connection",
            style:TextStyle(
              color: Colors.white,
              fontSize: 16.sp) ,
            )
          ]
         ),
      ),
    );
  }
}
