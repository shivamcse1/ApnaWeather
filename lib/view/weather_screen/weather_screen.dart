import 'dart:convert';
import 'package:apna_weather_app/view/forecast_screen/forecast_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  TextEditingController cityController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime now = DateTime.now();
  
  bool isLoading = true;
  String cityName="Lucknow";
  final String apiKey="a14e6dfcf36384aed661d1131ac9eba2";
  double windSpeed=0;
  double currentTemp=0; 
  String currentSkyCondition="";
  String currentSkyConditionDescription="";
  int atmPressure=0; 
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
             atmPressure = data["main"]["pressure"];
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
             child: AppBar(
             leading:IconButton(
              padding: const EdgeInsets.only(bottom: 10),
              onPressed: (){
             
             }, 
             icon: const Icon(Icons.location_on,
             color: Colors.white,
             ),
             ) ,
             backgroundColor: Colors.transparent,
             centerTitle: true,
             title:Padding(
               padding: const EdgeInsets.only(bottom: 10),
               child: Text("Lucknow",style: TextStyle(fontSize: 24.sp,color: Colors.yellow,fontWeight: FontWeight.bold),),
             ),  

             actions: [
              IconButton(
                padding: const EdgeInsets.only(bottom: 10),
               onPressed:(){
              
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
            
            :Padding(
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
               
                           Text(currentSkyCondition,
                           style: TextStyle(fontSize: 24.sp,color: Colors.white),),
                             Text("${currentTemp.toStringAsFixed(1)}°C",
                           style: TextStyle(
                             fontSize: 35.sp,
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
               
                           Text("Feels Like 23°C",style:TextStyle(fontSize: 16.sp,color: Colors.white)),
                           
                         ],
                       ),
                     ),
                     SizedBox(height: 20.h,),
               
                     // -------------Weather Details Section------------// 
                     Container(
                       alignment: Alignment.centerLeft,
                       child:   Text("Weather Details",style: TextStyle(fontSize: 20.sp,color: Colors.yellow,fontWeight: FontWeight.bold),),   
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
                                         Text("22 m/s",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
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
                                         Text("22 hPa",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
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
                                         Text("22%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
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
                                         Text("32°C",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
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
                                         Text("38°C",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
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
                                         Text("22%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.white),),
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
                       child:Text("Today",style: TextStyle(fontSize: 20.sp,color: Colors.yellow,fontWeight: FontWeight.bold),),   
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
                         
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForecastScreen()));
                        }, 
                       child:Text("Next 7 days >",style: TextStyle(fontSize: 16.sp,color: Colors.white,fontWeight: FontWeight.bold),) 
                       ),
                       ],
                     ),
                     SizedBox(height: 10.h,),
                          
                     SizedBox(
                     height: 120.h,
                      child: ListView.builder(
                       itemCount: 4,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (context,index){
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
                               Text("12 AM",
                               style: TextStyle(
                                 fontSize: 14.sp,
                                 color: Colors.white,
                               ),
                               ),
                               SizedBox(height: 8.h,),
                               
                               Icon(Icons.wb_sunny,size: 32.sp,color: Colors.orange,),
                               SizedBox(height: 8.h,),
                                        
                               Text("26°C",
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
      
         ) ,
      
           
      ),
    );
  }
}