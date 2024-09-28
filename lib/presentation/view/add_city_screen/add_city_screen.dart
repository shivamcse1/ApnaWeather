import 'package:apna_weather_app/core/constants/image_const.dart';
import 'package:apna_weather_app/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});

  @override
  State<AddCityScreen> createState() => AddCityScreenState();
}

class AddCityScreenState extends State<AddCityScreen> {
  TextEditingController cityNameController  = TextEditingController();
  List<String> cityNameList = [];
  String? cityNameRecieved ;
  
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 104, 71, 142),
                Color.fromARGB(255, 146, 33, 140),
              ]),
        ),
        child: Scaffold(

          backgroundColor: const Color.fromARGB(0, 169, 161, 161),
          appBar: AppBar(
            toolbarHeight: 40,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title:  Text("Pick Location",
            style: TextStyle(
             fontSize: 20.sp,
             color: Colors.yellow,
             fontWeight: FontWeight.w500),),  
             actions:  [

              IconButton(
                onPressed: (){
              
                },
               icon: const Icon(Icons.more_vert,color: Colors.white
               ))
             ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                 
                  Text(
                    "Select the city or area that you want to know the\n"
                    "detail info at this time",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  //-------------Card Part  --------------//
                  cityNameList.isEmpty 
                  ? SizedBox(
                    height: 500,
                    child:Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           
                            Image.asset(ImageConst.noCityFound2Img,
                            height: 80,),
                            SizedBox(height: 5.h,),
                            Text("No City Added",
                             style: TextStyle(fontSize: 18.sp,color: Colors.white,
                             fontWeight: FontWeight.w500
              
                             ),
                            )
                             ],
                            ),
                          )
                        )
                  : ListView.builder(
                    itemCount: cityNameList.length,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, 
                          AppRoutes.weatherScreen,
                          arguments:cityNameList[index].trim(),
                          );
                        },
                        onLongPress: (){
                          
                          showDialog(
                          context: context, 
                            builder: (context){
                              return  AlertDialog(
                                  title: Text("Do you want to delete",
                                  style: TextStyle(fontSize: 15.sp),),
                                  actionsPadding: const EdgeInsets.only(bottom: 5,right: 15),
                                  actions: [
                                  TextButton(
                                    onPressed:(){
                                    Navigator.pop(context);
                                    }, 
                                    child: Text("Cancel",style: TextStyle(fontSize: 15.sp),)
                                    ),
                                  
                                  TextButton(
                                    onPressed:() {

                                    cityNameList.removeAt(index);
                                    setState(() {
                                        Navigator.pop(context);
                                    });
                                    
                                    }, 
                                    child: Text("Delete",style: TextStyle(fontSize: 15.sp),)
                                  ),
                                  ],
                            
                              );
                              }
                            );

                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: SizedBox(
                            width: 100,
                            child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r)),
                              child: Container(
                                height: 160.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          const Color.fromARGB(255, 163, 87, 218)),
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: const Color(0xFF331868),
                                ),
                                child: Column(
                                  children: [
                        
                                    Container(
                                      margin:EdgeInsets.only(left: 10.w,top: 5.h,bottom: 5.h,right: 10.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                      
                                          SizedBox(
                                            width: 165.w,
                                            height: 144.3.h,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                        
                                                Text(
                                                  "32°C",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 28.sp,
                                                      color: Colors.yellow),
                                                ),
                                  
                                                Text("Feels Like 23°C",style:TextStyle(fontSize: 15.sp,color: Colors.white)),
                        
                                                SizedBox(height: 20.h,),
                                                Row(
                                                  children: [
                                                  Image.asset(
                                                    ImageConst.minTempIc,
                                                    height: 18.h,
                                                  ),
                                                    
                                                  Text(
                                                    "Min.35°C",
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color: Colors.white),
                                                  ),
                        
                                                  SizedBox(
                                                  height: 20.h,
                                                  child: const VerticalDivider(color: Colors.white,
                                                  thickness: 1.5,
                                                  )),
                                                  Text(
                                                    "Max.55°C",
                                                    style: TextStyle(
                                                        fontSize: 15.sp,
                                                        color: Colors.white),
                                                  ),],
                                                ),
                        
                                               SizedBox(height: 3.h,),
                        
                                               Row(
                                               
                                                children: [
                                                   const Icon(Icons.location_on_outlined,color: Colors.greenAccent,),
                                                   Text(cityNameList[index],style:TextStyle(fontSize: 20.sp,color: Colors.white)),
                                                ],
                                               )   
                                              ],
                                            ),
                                          ),
                                         
                                          const Spacer(),
                        
                                          SizedBox(
                                            width: 140,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset(
                                                  ImageConst.cloudImg,
                                                  width: 80.h,
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Text(
                                                  "22%",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18.sp,
                                                      color: Colors.white),
                                                ),
                                               Text("Cloudiness",style:TextStyle(fontSize: 20.sp,color: Colors.white)),
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
                          ),
                        ),
                      );
                    },
                  )
              
                ],
              ),
            ),
          ),
                
                //-------------Floating button Part  --------------//
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            backgroundColor: const Color.fromARGB(255, 207, 97, 97),
            onPressed: () async{
              
              // recieving data from next screen wait until data is not recieved
             final argument = await Navigator.pushNamed(context,AppRoutes.searchScreen);

             if(argument is String){
                 
                 if(argument.isEmpty){
                   return ;
                 }
                 else{
                  setState(() {
                    cityNameRecieved = argument;
                    cityNameList.add(cityNameRecieved![0].toUpperCase()+cityNameRecieved!.substring(1));
                  });
                 }
             }
             else{
               return;
             }
            },
            child: const Icon(Icons.add,
            color: Colors.yellow,
            ),
            ),
        )
        
    );
  
  }

  
}
