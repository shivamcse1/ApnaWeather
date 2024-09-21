import 'dart:convert';
import 'package:apna_weather_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  DateTime now = DateTime.now();
  double lat=0;
  double lang=0;
  String cityName="Lucknow";
  bool isLoading = true;
  final String apiKey="a14e6dfcf36384aed661d1131ac9eba2";
  Map<String,dynamic> currentWeatherData={};
  Map<String,dynamic> forecastData={};
  String countryName='';
  String forecastStartTime ='';


  Future<void> getCurrentWeather (String? locationName) async {
    try{
        String weatherApiUrl = "https://api.openweathermap.org/data/2.5/weather?q=$locationName&appid=$apiKey";
        String forecastApiUrl = "https://api.openweathermap.org/data/2.5/forecast?q=$locationName&appid=$apiKey";
        Uri weatherUriUrl = Uri.parse(weatherApiUrl);
        Uri forecastUriUrl = Uri.parse(forecastApiUrl);

        var weatherResponse = await http.get(weatherUriUrl);
        var forecastResponse = await http.get(forecastUriUrl);
        
        if(weatherResponse.statusCode==200 && forecastResponse.statusCode==200){
           currentWeatherData = jsonDecode(weatherResponse.body);
           forecastData = jsonDecode(forecastResponse.body);
           // ignore: avoid_print
           print('current weathr data----------$currentWeatherData');
           // ignore: avoid_print
           print('5 day forecast data----------$forecastData');
           
           setState(() {
             isLoading=false;
             countryName =", ${currentWeatherData["sys"]["country"]}";
           });
        }
        else if(weatherResponse.statusCode==404 || forecastResponse.statusCode==404){
               currentWeatherData = jsonDecode(weatherResponse.body);
               setState(() {
                 isLoading=false;
               });
        }
    }
    catch(e){
      Exception("Error Occured : $e");
    }
  }

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    cityName=ModalRoute.of(context)?.settings.arguments as String;
    getCurrentWeather(cityName);
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
            decoration: const BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              // Color.fromARGB(255, 165, 99, 178),
              // Color.fromARGB(255, 53, 198, 196),
            
            Color.fromARGB(255, 104, 71, 142),
            Color.fromARGB(255, 132, 60, 163),
              
          ]),
          ),
          child: Scaffold(
           backgroundColor: const Color.fromARGB(0, 169, 161, 161),
           appBar: PreferredSize(
            preferredSize: const Size(0, 30),
             child:AppBar(
           
             leading:IconButton(
              padding: const EdgeInsets.only(bottom: 10),
              onPressed: () async{
                getCurrentLocation();
                
             }, 
             icon: const Icon(Icons.location_on,
             color: Colors.white,
             ),
             ) ,
             backgroundColor: Colors.transparent,
             centerTitle: true,
             title:Text("${cityName[0].toUpperCase()+cityName.substring(1)}$countryName",
             style: TextStyle(fontSize: 20.sp,color: Colors.yellow,fontWeight: FontWeight.w500),),  

             actions: [

              currentWeatherData["cod"] == "404" 
              ? const SizedBox(height: 1,width: 1,)
              : IconButton(
                padding: const EdgeInsets.only(bottom: 10),
                onPressed:() async{
                   setState(() {
                      isLoading=true;
                   });
                   getCurrentWeather(cityName);
              }, 
              icon: const Icon(Icons.refresh,
              color: Colors.white,
              ))
             ], 
             )
             ), 
             body:Container(
                decoration: const BoxDecoration(
                gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  // Color.fromARGB(255, 165, 99, 178),
                  // Color.fromARGB(255, 53, 198, 196),
                
                Color.fromARGB(255, 104, 71, 142),
                Color.fromARGB(255, 132, 60, 163),
                  
              ]),
             ),
      
             child:isLoading? const Center(child:CircularProgressIndicator(
              color: Colors.amberAccent,
             ) ,) 
            
            :
            currentWeatherData["cod"] == "404" 
            ? SizedBox(
              height: 650,
              child:Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      
                      Image.asset("assets/icons/nocity2_ic.png",
                      height: 75,),
                      SizedBox(height: 5.h,),
                      Text("Oops! City Not Found ",
                        style: TextStyle(fontSize: 18.sp,color: Colors.white,
                        fontWeight: FontWeight.w500
        
                        ),
                      )
                        ],
                      ),
                    )
                  )
            : Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SingleChildScrollView(
                child: Column(
                 children: [
                     
                     // -------------Weather Section------------// 
                     SizedBox(height: 20.h,),   
                     SizedBox(
                       width: double.infinity,
                       child: Column(
                         children: [
               
                           Text(currentWeatherData["weather"][0]["main"],
                           style: TextStyle(fontSize: 24.sp,color: Colors.white),),
                             Text("${(currentWeatherData["main"]["temp"]-273.15).toStringAsFixed(1)}°C",
                           style: TextStyle(
                             fontSize: 34.sp,
                             fontWeight: FontWeight.bold,
                             color: Colors.white
                           ),
                           ),
                          
                          
                           SizedBox(
                             width: 150.h,
                             child: Image.asset("assets/images/thunderstrom.gif",
                             fit: BoxFit.cover,
                             ),
                           ),
                           SizedBox(height: 8.h,),
               
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               
                               Text("${now.day}",style:TextStyle(fontSize: 16.sp,color: Colors.white)),
                              
                               SizedBox(width: 5.w,),
                               Text(DateFormat("MMM").format(now),style:TextStyle(fontSize: 16.sp,color: Colors.white)),
                               SizedBox(width: 5.w,),
                               Text(DateFormat("EEEE").format(now),style:TextStyle(fontSize: 16.sp,color: Colors.white)),
                               SizedBox(
                                 height: 20.h,
                                 child: const VerticalDivider(color: Colors.white,
                                 thickness: 1.5,
                                 )),
                               Text(DateFormat('hh:mm a').format(now),style:TextStyle(fontSize: 16.sp,color: Colors.white)),
                               
                             ],
                           ),
               
                           Text("Feels Like ${(currentWeatherData["main"]["feels_like"]-273.15).toStringAsFixed(1)}°C",style:TextStyle(fontSize: 16.sp,color: Colors.white)),
                           
                         ],
                       ),
                     ),
                     SizedBox(height: 20.h,),
               
                     // -------------Weather Details Section------------// 
                     Container(
                       alignment: Alignment.centerLeft,
                       child:   Text("Weather Details",style: TextStyle(fontSize: 20.sp,color: Colors.yellow,fontWeight: FontWeight.w500),),   
                     ),
                     SizedBox(height: 10.h,),
               
                     Card(
                      margin: EdgeInsets.zero,
                       elevation: 6,
                       shape: RoundedRectangleBorder(
                         
                         borderRadius: BorderRadius.circular(16.r)
                       ),
                       child: Container(
                         width: double.infinity,
                         height: 250.h,
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
                              
                              SizedBox(height: 5.h,),
                              Container(
                               margin:EdgeInsets.symmetric(horizontal: 3.w,vertical: 10.h),
                               child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                  
                                  Container(
                                   margin: EdgeInsets.only(left: 5.w),
                                     width: 87.w,
                                     height: 100.h,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Image.asset("assets/icons/wind_day_ic.gif",height: 40.h,),
                                          SizedBox(height: 8.h,),
                                         Text("${currentWeatherData["wind"]["speed"]} m/s",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
                                         Text("Wind Speed",style: TextStyle(fontSize: 14.sp,color: Colors.white),),
                               
                                         
                                       ],
                                     ),
                                   ),
                               
                                  SizedBox(
                                     width: 100.w,
                                     height: 100.h,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                       
                                         Image.asset("assets/icons/atomosphericpressure_ic.png",height: 40.h,),
                                          SizedBox(height: 8.h,),
                                         Text("${currentWeatherData["main"]["pressure"]} hPa",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
                                         Text("Atm Pressure",style: TextStyle(fontSize: 14.sp,color: Colors.white),),
                               
                                         
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
                                         Text("${currentWeatherData["main"]["humidity"]}%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
                                         Text("Humidity",style: TextStyle(fontSize: 14.sp,color: Colors.white),),
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
                                       
                                   Container(
                                     margin: EdgeInsets.only(left: 10.w),
                                     width: 80.w,
                                     height: 100.h,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Image.asset("assets/icons/min_temp2_ic.png",height: 40.h,),
                                          SizedBox(height: 8.h,),
                                         Text("${(currentWeatherData["main"]["temp_min"]-273.15).toStringAsFixed(2)}°C",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
                                         Text("Min Temp.",style: TextStyle(fontSize: 14.sp,color: Colors.white),),
                                         
                                       ],
                                     ),
                                   ),
                               
                                   SizedBox(
                                     width: 95.w,
                                     height: 100.h,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                       
                                         Image.asset("assets/icons/max_temp_ic.png",height: 40.h,),
                                          SizedBox(height: 8.h,),
                                         Text("${(currentWeatherData["main"]["temp_max"]-273.15).toStringAsFixed(1)}°C",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
                                         Text("Max Temp.",style: TextStyle(fontSize: 14.sp,color: Colors.white),),
                               
                                         
                                       ],
                                     ),
                                   ),
                               
                                   SizedBox(
                                     width: 85.w,
                                     height: 100.h,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                          Image.asset("assets/icons/cloud_ic.png",height: 40.h,),
                                          SizedBox(height: 8.h,),
                                         Text("${currentWeatherData["clouds"]["all"]}%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
                                         Text("Cloudiness",style: TextStyle(fontSize: 14.sp,color: Colors.white),),
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
                      
                      // -------------Today Weather Section------------// 
                     SizedBox(height: 15.h,),
                     Row(
                       children: [
               
                       Container(
                       alignment: Alignment.centerLeft,
                       child:Text("Today",style: TextStyle(fontSize: 20.sp,color: Colors.yellow,fontWeight: FontWeight.w500),),   
                        ),
               
                       const Spacer(),
               
                       TextButton(
                         style: TextButton.styleFrom(
                           shape: const RoundedRectangleBorder(),
                           padding: EdgeInsets.zero,
                           minimumSize: Size.zero,
                           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        
                         ),
                         onPressed:(){
                         
                         Navigator.pushNamed(context, AppRoutes.forecastScreen,arguments: {
                          "forecastData":forecastData,
                          "currentWeatherData":currentWeatherData
                         });
                        }, 
                       child:Text("Next 5 days >",style: TextStyle(fontSize: 16.sp,color: Colors.yellow,fontWeight: FontWeight.bold),) 
                       ),
                       ],
                     ),
                     SizedBox(height: 10.h,),
                     Align(
                     alignment: Alignment.centerLeft,
                     child: Text("Next 24 Hours",style: TextStyle(fontSize: 16.sp,color: Colors.yellow,fontWeight: FontWeight.bold),)) ,
                     SizedBox(height: 10.h,),    
                     SizedBox(
                     height: 120.h,
                      child: ListView.builder(
                       itemCount: 9,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (context,index){                          
                        
                       forecastStartTime = forecastData['list'][index]['dt_txt'];
                       DateTime dateTime = DateTime.parse(forecastStartTime);

                       String currentForecastTime = DateFormat('hh:mm a').format(dateTime);

                       return Container(
                       padding: const EdgeInsets.only(right: 3),
                       width: 100.w,
                       child: Card(
                         color: const Color(0xFF331868),
                         elevation: 6,
                         child: Container(
                           margin: const EdgeInsets.only(top: 5),
                           child:Column(
                             children: [
                               Text(currentForecastTime,
                               style: TextStyle(
                                 fontSize: 14.sp,
                                 color: Colors.white,
                               ),
                               ),
                               SizedBox(height: 8.h,),
                               
                               Icon(Icons.wb_sunny,size: 32.sp,color: Colors.orange,),
                               SizedBox(height: 8.h,),
                                        
                               Text('${(forecastData["list"][index]['main']['temp']-273.15).toStringAsFixed(2)}°C',
                               style: TextStyle(
                                 fontSize: 14.sp,
                                 color: Colors.white, 
                                 
                                 ),),
                               SizedBox(height: 5.h,),
                             ],
                           ),
                         ),
                       ),
                       );
                      },
                     ),
                    ),
                    SizedBox(height: 25.h,),
                 ],
               ),
             ),
           ), 
      
         ) ,
      
           
      ),
    );
  }

  void getCurrentLocation() async{
    
    // check device location enable or not 
    bool serviceEnable ;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
       await Geolocator.openLocationSettings();
       return ;
    }
    
    //if enable then proceed 
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
        LocationPermission askAgain = await Geolocator.requestPermission();
        if(askAgain==LocationPermission.denied || askAgain==LocationPermission.deniedForever){
          return ;
        }
    }
    else if(permission ==LocationPermission.deniedForever){
      return ;
    }
    else{
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      lang=position.longitude;
      lat= position.latitude;
    }

  }
}