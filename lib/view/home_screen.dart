import 'dart:convert';
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  TextEditingController cityController = TextEditingController();
  bool isLoading = true;
  String cityName="Lucknow";
  final String apiKey="a14e6dfcf36384aed661d1131ac9eba2";
  double windSpeed=0;
  double currentTemp=0; // in 
  String currentSkyCondition="";
  String currentSkyConditionDescription="";
  int airPressure=0; //
  int humidity =0;
  int cloud =0;
  String placeName="";

  Future<void> getWeather () async {

    try{
        String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey";
        Uri weatherUriUrl = Uri.parse(apiUrl);
        var weatherResponse = await http.get(weatherUriUrl);
        if(weatherResponse.statusCode==200){
          final data = jsonDecode(weatherResponse.body);
           
           setState(() {
             
             currentTemp = (data["main"]["temp"]-273.15);
             currentSkyCondition = data["weather"][0]["main"];

             isLoading=false;
             currentSkyConditionDescription = data["weather"][0]["description"];
            //  cloud = data["clouds"]["all"];
             windSpeed = data["wind"]["speed"];
             humidity = data["main"]["humidity"];
             airPressure = data["main"]["pressure"];
           });
        }
        else{
          print("Error Occured");
        }
      String forcastApiUrl ="api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey";
      Uri forcastUriUrl = Uri.parse(forcastApiUrl);

     var forcastResponse = await http.get(forcastUriUrl);
     if(forcastResponse.statusCode==200){
      final forcastData = jsonDecode(forcastResponse.body);
      print(forcastData);
     }
     else{

      print("error occured in forcast");
     }


    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          backgroundColor: const Color(0xFF274757),
          title: Text(cityName[0].toUpperCase() + cityName.substring(1),style: const TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),

            actions: [
              IconButton(
                
                onPressed: () async{
                  setState(() {
                    isLoading = true;
                  });

                 await getWeather();
              }, 
              icon: const Icon(Icons.refresh,color: Colors.white,)),
            ],
        ),
        body: isLoading? const Center(child:CircularProgressIndicator() ,) 
        
         :SingleChildScrollView(
           child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                        
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                                      
                          Text("${currentTemp.toStringAsFixed(2)}°C",
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                                      
                          Icon(Icons.wb_sunny,size: 64.sp,color: Colors.orange,),
                          SizedBox(height: 8.h,),
                                      
                          Text("$currentSkyCondition",style: TextStyle(fontSize: 24.sp),)
                        ],
                      ),
                    ),
                  ),
            
                  SizedBox(height: 15.h,),
            
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Hourly Forcast",style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 15.h,),
           
                 SizedBox(
                  height: 120.h,
                   child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                      width: 100.w,
                      child: Card(
                        elevation: 6,
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: 100.w,
                          child:Column(
                            children: [
                              Text("12:00",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                              SizedBox(height: 8.h,),
                              
                              Icon(Icons.wb_sunny,size: 32.sp,color: Colors.orange,),
                              SizedBox(height: 8.h,),
                                       
                              Text("26 °C",style: TextStyle(fontSize: 16.sp),),
                              SizedBox(height: 5.h,),
                            ],
                          ),
                        ),
                      ),
                      ),
                    );
                   },
                  itemCount: 5,
                  
                  ),
                 ),
                 SizedBox(height: 15.h,),
           
                 Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Weather Details",style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),
                    ),
                ),
                SizedBox(height: 15.h,),
           
                Row(
                    children: [
                       
                      Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                      width: 105.w,
                      child: Card(
                        elevation: 6,
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: 100.w,
                          child:Column(
                            children: [
           
                              Icon(Icons.water_drop,size: 32.sp,color: Colors.blue,),
                              SizedBox(height: 8.h,),
                              Text("Humidity",
                              style: TextStyle(
                                fontSize: 16.sp,
                                
                              ),
                              ),
                              SizedBox(height: 8.h,),
                              Text("$humidity %",style: TextStyle(fontSize: 16.sp),),
                              SizedBox(height: 5.h,),
                            ],
                          ),
                        ),
                      ),
                     ),
                    ),
            
                Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                      width: 105.w,
                      child: Card(
                        elevation: 6,
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: 100.w,
                          child:Column(
                            children: [
                              Icon(Icons.wind_power,size: 32.sp,color: Colors.blue,),
                              SizedBox(height: 8.h,),
           
                              Text("Wind Speed",
                              style: TextStyle(
                                fontSize: 16.sp,
                                
                              ),
                              ),
                              SizedBox(height: 8.h,),
                              Text("$windSpeed m/s",style: TextStyle(fontSize: 16.sp),),
                              SizedBox(height: 5.h,),
                            ],
                          ),
                        ),
                      ),
                      ),
                    ),
           
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                      width: 105.w,
                      child: Card(
                        elevation: 6,
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: 100.w,
                          child:Column(
                            children: [
                              Icon(Icons.arrow_downward,size: 32.sp,color: Colors.blue,),
                              SizedBox(height: 8.h,),
           
                              Text("Air Pressure",
                              style: TextStyle(
                                fontSize: 16.sp,
                              ),
                              ),
                              SizedBox(height: 8.h,),
           
                              Text("$airPressure hPa",style: TextStyle(fontSize: 16.sp),),
                              SizedBox(height: 5.h,),
                            ],
                          ),
                        ),
                      ),
                      ),
                    ),
            
                   ],
                  ),
           
                  SizedBox(height: 40.h,),
           
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.sp)
                      )
                    ),
                    onPressed: (){
                       showDialog(context: context, 
                       builder: (context){
                        return  AlertDialog(
                            
                            title: const Text("Search City"),
           
                            content: TextFormField(
                              controller: cityController,
                              decoration: const InputDecoration(
                                hintText: "Enter City Name",
                              ),
                              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))],
                            
                            ),
                            actions: [
                              TextButton(onPressed:(){
                               Navigator.pop(context);
                              }, 
                              child: Text("Cancel",style: TextStyle(fontSize: 16.sp),)),
                             
                              TextButton(onPressed:() async{
                              setState(() {
                               isLoading=true;
                               cityName=cityController.text;
                              
                              });
                              Navigator.pop(context);
                              await getWeather(); 
                              
                               
                              }, 
                              child: Text("Search",style: TextStyle(fontSize: 16.sp),)),
                            ],
           
                         );
                        }
                      );
                    },
                    child:Text("Change City",
                    style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: Colors.white),) 
                    ,),
                  ),
              ],
            ),
                   ),
         ),
    );
  }
}