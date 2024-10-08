import 'dart:convert';
import 'dart:developer';
import 'package:apna_weather_app/core/constants/image_const.dart';
import 'package:apna_weather_app/data/local_database/shared_preference/shared_preference_storage.dart';
import 'package:apna_weather_app/data/services/current_location_service.dart';
import 'package:apna_weather_app/core/routes/app_routes.dart';
import 'package:apna_weather_app/data/services/api_helper/api_url_helper.dart';
import 'package:apna_weather_app/utils/city_not_found.dart';
import 'package:apna_weather_app/utils/uihelper/weather_image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  DateTime now = DateTime.now();
  dynamic argument ;
  
  LocalDataBaseHelper localdatabase =LocalDataBaseHelper();

  String cityName="";
  bool isLatLongUsed = false;
  bool isLocationUsed = false;
  bool isCityNameUsed = false;

  bool isLoading = true;
  Map<String,dynamic> myLocationData={};
  Map<String,dynamic> currentWeatherData={};
  Map<String,dynamic> forecastData={};
  String countryName='';
  String forecastStartTime ='';

  // mrthod for getting weather
  Future<void> getCurrentWeather ({String? locationName, double? latitude, double? longitude ,bool? isCityUsed = false } ) async {
    Map<String,String> urlMap={};
    locationName==null 
    ? urlMap = ApiUrlHelper.getWeatherUrlByLatLong(lat: latitude!, long: longitude!)
    : urlMap = ApiUrlHelper.getWeatherUrlByCityName(cityName:locationName);
  
    try{
       
        Uri weatherUriUrl = Uri.parse(urlMap['currentWeather']!);
        Uri forecastUriUrl = Uri.parse(urlMap['forecast']!);
        
        var weatherResponse = await http.get(weatherUriUrl);
        var forecastResponse = await http.get(forecastUriUrl);
        
        if(weatherResponse.statusCode==200 && forecastResponse.statusCode==200){
           currentWeatherData = jsonDecode(weatherResponse.body);
           forecastData = jsonDecode(forecastResponse.body);
           log("Weather data --------$currentWeatherData");
         
           if(isCityUsed==true){
              
             Map data = LocalDataBaseHelper.databaseHelper(data: currentWeatherData);
             localdatabase.setData(weatherData:jsonEncode(data));
           }

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
      log("Error Occured : $e");
    }
  }


   @override
  void didChangeDependencies() async{

    super.didChangeDependencies();
    if(isLocationUsed ) {return;}
    else{
      argument = ModalRoute.of(context)?.settings.arguments;
     if(argument is String){
      cityName = argument;
     
      if(isCityNameUsed == false)  {
       isCityNameUsed = true ;
       await getCurrentWeather(locationName: cityName, isCityUsed: isCityNameUsed);
      }
      else{
       await getCurrentWeather(locationName: cityName);
      }
    }
    else if(argument is Map){
           
           if(argument.length==1){
             cityName = argument['cityname'];
             await getCurrentWeather(locationName: cityName);
           }
           else
           {
            isLatLongUsed=true;
            cityName=argument['place_name'];
            setState(() {
              
            });
          await getCurrentWeather(latitude: argument['lat'],longitude: argument['long']);
        }
        
    }
    else{
      cityName ="Lucknow";
      await getCurrentWeather(locationName: cityName,);
    }
  }
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
                setState(() {
                  isLoading=true;
                 
                });
               
                myLocationData = await LocationService.getCurrentLocation();
                isLocationUsed=true;
                myLocationData['latitude']== null 
                ? setState(() {
                 isLoading=false;
                })
               : await getCurrentWeather(latitude: myLocationData["latitude"],longitude: myLocationData['longitude']);
               
             }, 
             icon: const Icon(Icons.location_on,
             color: Colors.white,
             ),
             ) ,
             backgroundColor: Colors.transparent,
             centerTitle: true,
             title:
              Text(
                //20letter
                isLatLongUsed && isLocationUsed==false ? cityName.length <=18 ? cityName + countryName : cityName.substring(0,18)+'...' + countryName
              
               : currentWeatherData["name"] == null

               ? "${cityName[0].toUpperCase()+cityName.substring(1)}$countryName"
               
               : "${currentWeatherData["name"][0].toUpperCase()+currentWeatherData["name"].substring(1)}$countryName",
             
             style: TextStyle(fontSize: 20.sp,color: Colors.yellow,fontWeight: FontWeight.w500),),  

             actions: [

              currentWeatherData["cod"] == "404" || isLocationUsed == false
              ? isLatLongUsed 
              ? IconButton(
                padding: const EdgeInsets.only(bottom: 10),
                onPressed:() async{
                   setState(() {
                      isLoading=true;
                   });
                   getCurrentWeather(latitude: argument['lat'],longitude: argument['long']);
              }, 
              icon: const Icon(Icons.refresh,
              color: Colors.white,
              ))
              
              : IconButton(
                padding: const EdgeInsets.only(bottom: 10),
                onPressed:() async{
                   setState(() {
                      isLoading=true;
                   });
                   getCurrentWeather(locationName: cityName);
              }, 
              icon: const Icon(Icons.refresh,
              color: Colors.white,
              ))

             : IconButton(
                padding: const EdgeInsets.only(bottom: 10),
                onPressed:() async{
                   setState(() {
                      isLoading=true;
                   });
                   getCurrentWeather(latitude: myLocationData["latitude"],longitude: myLocationData['longitude']);
              }, 
              icon: const Icon(Icons.refresh,
              color: Colors.white,
              )),
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
      
             child:isLoading? Center(
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Colors.yellow,),
                  SizedBox(height: 8.h,),
                  Text('Please Wait....',style:TextStyle(color: Colors.white,fontSize: 16.sp) ,)
                ],
               ),
             )
            
            :
            currentWeatherData["cod"] == "404" 
            ? cityNotFound()
            : cityName.isEmpty && isLatLongUsed == false 
            ? cityNotFound(msg: "Invalid City Name")
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
                            height: 140.h,
                            //  width: 150.w,
                             child: Image.asset(WeatherImageHelper.weatherImagePath(skyCondition: currentWeatherData["weather"][0]["main"]),
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
                                         Image.asset(ImageConst.windDayIc,height: 40.h,),
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
                                       
                                         Image.asset(ImageConst.atmPressureIc,height: 40.h,),
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
                                          Image.asset(ImageConst.humidityDayIc,height: 40.h,),
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
                                         Image.asset(ImageConst.minTempIc,height: 40.h,),
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
                                       
                                         Image.asset(ImageConst.maxTempIc,height: 40.h,),
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
                                          Image.asset(ImageConst.cloudImg,height: 40.h,),
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
                       int time24Format =  dateTime.hour;
                       String weatherCondition =forecastData["list"][index]['weather'][0]['main'];

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
                               
                               Image.asset(WeatherImageHelper.weatherForecastImagePath(skyCondition: weatherCondition,hour: time24Format ),height: 32.sp),
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
 
}