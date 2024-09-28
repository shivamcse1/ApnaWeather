import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

 Widget cityNotFound({String? msg="Oops! City Not Found ",double? h=650}){
    return SizedBox(
      height: h,
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              
              Image.asset("assets/icons/nocity2_ic.png",
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
