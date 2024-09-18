import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherDetailCardScreen extends StatefulWidget {
  const WeatherDetailCardScreen ({super.key});
  
  @override
  State<StatefulWidget> createState()=>WeatherDetailCardScreenState();

}

class WeatherDetailCardScreenState extends State<WeatherDetailCardScreen > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Card(
                shape: RoundedRectangleBorder(
                
                borderRadius: BorderRadius.circular(16.r)
              ),
              child: Container(
                height: 250.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 163, 87, 218)
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  color: const Color(0xFF331856),
                ),
                
                
                child: Column(
                  children: [
                      
                      SizedBox(height: 5.h,),
                      Container(
                      margin:EdgeInsets.symmetric(horizontal: 3.w,vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              
                          SizedBox(
                            width: 80.w,
                            height: 100.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/icons/umbrella_day_ic.png",height: 40.h,),
                                  SizedBox(height: 8.h,),
                                Text("22%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,color: Colors.white),),
                                Text("Rain",style: TextStyle(fontSize: 16.sp,color: Colors.white),),
                      
                                
                              ],
                            ),
                          ),
                      
                          SizedBox(
                            width: 87.w,
                            height: 100.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/icons/wind_day_ic.gif",height: 40.h,),
                                  SizedBox(height: 8.h,),
                                Text("22 m/s",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,color: Colors.white),),
                                Text("Wind Speed",style: TextStyle(fontSize: 16.sp,color: Colors.white),),
                      
                                
                              ],
                            ),
                          ),
                      
                          SizedBox(
                            width: 80.w,
                            height: 100.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Image.asset("assets/icons/humidity_day_ic.png",height: 40.h,),
                                  SizedBox(height: 8.h,),
                                Text("22%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,color: Colors.white),),
                                Text("Humidity",style: TextStyle(fontSize: 16.sp,color: Colors.white),),
                              ],
                            ),
                          ),
                        
                        ],
                      ),
                    ),

                      Container(
                      margin:EdgeInsets.symmetric(horizontal: 3.w,vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                              
                          SizedBox(
                            width: 80.w,
                            height: 100.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/icons/umbrella_day_ic.png",height: 40.h,),
                                  SizedBox(height: 8.h,),
                                Text("22%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,color: Colors.white),),
                                Text("Rain",style: TextStyle(fontSize: 16.sp,color: Colors.white),),
                      
                                
                              ],
                            ),
                          ),
                      
                          SizedBox(
                            width: 87.w,
                            height: 100.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("assets/icons/wind_day_ic.gif",height: 40.h,),
                                  SizedBox(height: 8.h,),
                                Text("22 m/s",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,color: Colors.white),),
                                Text("Wind Speed",style: TextStyle(fontSize: 16.sp,color: Colors.white),),
                      
                                
                              ],
                            ),
                          ),
                      
                          SizedBox(
                            width: 80.w,
                            height: 100.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Image.asset("assets/icons/humidity_day_ic.png",height: 40.h,),
                                  SizedBox(height: 8.h,),
                                Text("22%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.sp,color: Colors.white),),
                                Text("Humidity",style: TextStyle(fontSize: 16.sp,color: Colors.white),),
                              ],
                            ),
                          ),
                        
                        ],
                      ),
                    ),
                      
                    
                  ],
                ),
              
              ),
            ),

    );
  }
}