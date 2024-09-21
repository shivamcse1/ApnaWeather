
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => ForecastScreenState();
}

class ForecastScreenState extends State<ForecastScreen> {
  DateTime now = DateTime.now();
  Map<String,dynamic> currentdata={};
  List<dynamic> dailyForecasts =[];
  List<dynamic> forecastList = [];
  String date ='';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentdata = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    forecastList= currentdata["forecastData"]['list'];

    // Filter for 09:00 AM entries
       dailyForecasts = forecastList.where((forecast) {
       String dateTime = forecast['dt_txt'];
       return dateTime.contains('09:00:00'); // Filter for 9 AM forecasts
      }).toList();

      print("daily forecast ------$dailyForecasts");

    }
  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
         
        Color.fromARGB(255, 104, 71, 142),
        Color.fromARGB(255, 132, 60, 163),
              
          ]),
          ),
      child: Scaffold(
       backgroundColor: const Color.fromARGB(0, 169, 161, 161),
        appBar: PreferredSize(
        preferredSize: const Size(0, 30),
         child: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("5 Day Forecast",style: TextStyle(fontSize: 20.sp,color: Colors.yellow,fontWeight: FontWeight.w500),), 
          leading: IconButton(
          padding: const EdgeInsets.only(bottom: 10),
          onPressed:(){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_sharp,color: Colors.white,)),
         
         ),
       ),
       body: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
         child: Container(
           decoration: const BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                
              Color.fromARGB(255, 104, 71, 142),
              Color.fromARGB(255, 132, 60, 163),
                
            ]),
            ),
          
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal:10 ),
             child: Column(
               children: [
                SizedBox(height: 20.h,),
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
                                     Text("Today",
                                      // DateFormat('EEEE').format(now),
                                     style: TextStyle(fontSize: 20.sp,color: Colors.white,),),
                                     
                                     const SizedBox(height: 10,),
                                     Text("${(currentdata["currentWeatherData"]['main']['temp']-273.15).toStringAsFixed(1)}°C",
                                     style: const TextStyle(fontSize: 34,color: Colors.white,fontWeight: FontWeight.bold)
                                     ),
                                     const SizedBox(height: 10,),
                    
                                     Text(currentdata["currentWeatherData"]['weather'][0]["main"],
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
                                       Text("${currentdata['currentWeatherData']['wind']['speed']} m/s",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
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
                                       Text("${currentdata['currentWeatherData']['main']['pressure']} hPa",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
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
                                       Text("${currentdata['currentWeatherData']['main']['humidity']}%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
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
                 
                 // finding day name using date 
                 DateTime dateTime = DateTime.parse(dailyForecasts[index]["dt_txt"]); 
                 int weekDay = dateTime.weekday;
                 String dayNames = getWeekDayName(weekDay);

                 return SizedBox(
                   height: 70.h,
                   child: Row(
                     children: [
                       SizedBox(
                         width: 95.h,
                         child: Text(dayNames,
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
                        Text(dailyForecasts[index]['weather'][0]['main'],
                        style: TextStyle(fontSize: 15.sp,color: Colors.white),
                       ),
                 
                       const Spacer(),
                 
                       Text("${(dailyForecasts[index]['main']['temp_min']-273.15).toStringAsFixed(1)}°C /"
                       
                        '${(dailyForecasts[index]['main']['temp_max']-273.15).toStringAsFixed(0)}°C',
                        style: TextStyle(fontSize: 15.sp,color: Colors.white),
                       ),
                     ],
                   ),
                 );
               },
               itemCount: dailyForecasts.length,
               ),
                  
               SizedBox(height: 30.h,)
                  
                    ],
                   ),
           ),
                ),
       ),
            ),
    );
  }

  String getWeekDayName(int weekDays){

    switch(weekDays){

      case 1 :
      return 'Monday';
      case 2 :
      return 'Tuesday';
      case 3 :
      return 'Wednesday';
      case 4 :
      return 'Thursday';
      case 5 :
      return 'Friday';
      case 6 :
      return 'Saturday';
      case 7 :
      return 'Sunday';
      default :
      return "Invalid Day";
    }
  }
}