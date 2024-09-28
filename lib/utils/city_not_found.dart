import 'package:apna_weather_app/core/constants/image_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 Widget cityNotFound({String? msg="Oops! City Not Found ",double? h=650}){
    return SizedBox(
      height: h,
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              
              Image.asset(ImageConst.noCityFound2Img,
              height: 75,),
              SizedBox(height: 5.h,),
              Text(msg!,
                style: TextStyle(fontSize: 16.sp,color: Colors.white,
                fontWeight: FontWeight.w500

                ),
              )
                ],
              ),
          )
        );
  }
