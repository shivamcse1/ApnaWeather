
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => ForecastScreenState();
}

class ForecastScreenState extends State<ForecastScreen> {

  List<String> currentSky = [
       "Cloudy",
       "Thunderstrom",
       "Few Clouds",
       "Clear Sky",
       "Rain",
       "Mist",
       "Snow",
      //  "Haze"

  ];
  List<String> dayNames = [
       "Sunday",
       "Monday",
       "Tuesday",
       "Wednesday",
       "Thursday",
       "Friday",
       "Saturday",

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBodyBehindAppBar: true, 
         appBar: PreferredSize(
          preferredSize: const Size(0, 20),
           child: AppBar(
            // centerTitle: true,
            // title: Text("7 Day Forecast",style: TextStyle(color: Colors.white,),),
            leading: IconButton(
            padding: const EdgeInsets.only(bottom: 20),
            onPressed:(){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_sharp,color: Colors.white,)),
          
            backgroundColor: Colors.transparent
           
           ),
         ),
         body: Container(
          
          decoration: const BoxDecoration(
           gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                // Color.fromARGB(255, 165, 99, 178),
                // Color.fromARGB(255, 53, 198, 196),
              
              Color.fromARGB(255, 104, 71, 142),
              Color.fromARGB(255, 132, 60, 163),
            ]
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 10.w,right: 10.w),
              child: Column(
                children: [
                  SizedBox(height: 100.h,),
                
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      
                      borderRadius: BorderRadius.circular(16.r)
                    ),
                    child: Container(
                      height: 300.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 163, 87, 218)
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        color: const Color(0xFF331868),
                        // color: Color.fromARGB(255, 42, 156, 118),
              
                      ),
                      
                      
                      child: Column(
                        children: [

                            Container(
                            margin:EdgeInsets.only(left: 20.w,right:20.w,top: 15.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
            
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Image.asset("assets/images/snowy.png",
                                   width: 110.w,
                                   height: 140,
                                  ),
                                ),
            
                                SizedBox(
                                 
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    
                                    children: [
                                      Text("Sunday",
                                      style: TextStyle(fontSize: 20.sp,color: Colors.white,),),
                                      
                                      const SizedBox(height: 10,),
                                      const Text("25°C",
                                      style: TextStyle(fontSize: 34,color: Colors.white,fontWeight: FontWeight.bold)
                                      ),
                                      const SizedBox(height: 10,),
            
                                      Text("Mostly Cloudy",
                                       style: TextStyle(fontSize: 20.sp,color: Colors.white,),),
                                    ],
                                  ),
                                )
            
            
                              ],
                            ),
                          ),
              
                            Container(
                            margin:EdgeInsets.only(left: 20.w,right: 20.w,top: 20.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                    
                                 Container(
                                  margin: EdgeInsets.only(left: 5.w),
                                    width: 85.w,
                                    height: 95.h,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/icons/wind_day_ic.gif",height: 40.h,),
                                         SizedBox(height: 8.h,),
                                        Text("22 m/s",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
                                        Text("Wind Speed",style: TextStyle(fontSize: 14.sp,color: Colors.white),),
                                        
                                      ],
                                    ),
                                  ),
                              
                                 SizedBox(
                                    width: 100.w,
                                    height: 95.h,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      
                                        Image.asset("assets/icons/atomosphericpressure_ic.png",height: 40.h,),
                                         SizedBox(height: 8.h,),
                                        Text("22 hPa",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
                                        Text("Atm Pressure",style: TextStyle(fontSize: 14.sp,color: Colors.white),),
                              
                                        
                                      ],
                                    ),
                                  ),
                                  
                                 SizedBox(
                                    width: 80.w,
                                    height: 95.h,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                         Image.asset("assets/icons/humidity_day_ic.png",height: 40.h,),
                                         SizedBox(height: 8.h,),
                                        Text("22%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
                                        Text("Humidity",style: TextStyle(fontSize: 14.sp,color: Colors.white),),
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
             
                SizedBox(height:10.h ,),
                ListView.builder(
                  padding: EdgeInsets.zero, 
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                  return SizedBox(
                    height: 70.h,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 95.h,
                          child: Text(dayNames[index],
                           style: TextStyle(fontSize: 15.sp,color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 15.w,),
                        SizedBox(
                          height: 50.h,
                          child: Image.asset("assets/icons/forecast_fewclouds_day_ic.png",
                          
                          ),
                        ),
                        
                        SizedBox(width: 5.w,),
                         Text(currentSky[index],
                         style: TextStyle(fontSize: 15.sp,color: Colors.white),
                        ),
                  
                        const Spacer(),
                  
                        Text("35°C / 40°C",
                         style: TextStyle(fontSize: 15.sp,color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 7,
                ),

                SizedBox(height: 30.h,)
          
            ],
           ),
          ),
        ),
      ),

    );
  }
}