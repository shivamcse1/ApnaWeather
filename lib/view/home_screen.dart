import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: true,
          backgroundColor: const Color(0xFF274757),
          title: const Text("Weather App",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),

            actions: [
              IconButton(onPressed: (){

              }, 
              icon: const Icon(Icons.search,color: Colors.white,)),
            ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
                      
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                                    
                        Text("26 °C",
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                                    
                        Icon(Icons.wb_sunny,size: 64.sp,color: Colors.orange,),
                        SizedBox(height: 10.h,),
                                    
                        Text("Sunny",style: TextStyle(fontSize: 24.sp),)
                      ],
                    ),
                  ),
                ),
          
                SizedBox(height: 20.h,),
          
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Hourly Forcast",style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 15.h,),

               Container(
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
                  child: Text("Additional Information",style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),
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
                            Text("26%",style: TextStyle(fontSize: 16.sp),),
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
                            Icon(Icons.water_drop,size: 32.sp,color: Colors.blue,),
                            SizedBox(height: 8.h,),

                            Text("Humidity",
                            style: TextStyle(
                              fontSize: 16.sp,
                              
                            ),
                            ),
                            SizedBox(height: 8.h,),
                            Text("26%",style: TextStyle(fontSize: 16.sp),),
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
                            Icon(Icons.water_drop,size: 32.sp,color: Colors.blue,),
                            SizedBox(height: 8.h,),

                            Text("Humidity",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                            ),
                            SizedBox(height: 8.h,),

                            Text("26%",style: TextStyle(fontSize: 16.sp),),
                            SizedBox(height: 5.h,),
                          ],
                        ),
                      ),
                    ),
                    ),
                  ),
          
                 ],
                )
            ],
          ),
        ),
    );
  }
}