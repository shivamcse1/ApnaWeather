import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CityNotFound{

 static Widget cityNotFound({String? msg="Oops! City Not Found "}){

    return SizedBox(
      height: 650,
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              
              Image.asset("assets/icons/nocity2_ic.png",
              height: 75,),
              SizedBox(height: 5.h,),
              Text(msg!,
                style: TextStyle(fontSize: 18.sp,color: Colors.white,
                fontWeight: FontWeight.w500

                ),
              )
                ],
              ),
          )
        );
  }
}