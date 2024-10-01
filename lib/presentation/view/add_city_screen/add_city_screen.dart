import 'dart:convert';

import 'package:apna_weather_app/core/constants/database_key_const.dart';
import 'package:apna_weather_app/core/constants/image_const.dart';
import 'package:apna_weather_app/core/routes/app_routes.dart';
import 'package:apna_weather_app/data/local_database/shared_preference/shared_preference_storage.dart';
import 'package:apna_weather_app/main.dart';
import 'package:apna_weather_app/utils/uihelper/toast_message_helper.dart';
import 'package:apna_weather_app/utils/uihelper/weather_image_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});

  @override
  State<AddCityScreen> createState() => AddCityScreenState();
}

class AddCityScreenState extends State<AddCityScreen> with RouteAware {
  LocalDataBaseHelper localdatabase = LocalDataBaseHelper();
  TextEditingController cityNameController  = TextEditingController();
  List cityNameList =[];
  dynamic cityList;
  @override
  void initState() {
    super.initState();
  
    cityList = localdatabase.getData();
    if(cityList==null){  setState(() {  cityNameList = []; });  }
    else{
     cityNameList = cityList.map((indexItem){
         return jsonDecode(indexItem);
      }).toList();
      setState(() {
        print(cityNameList.length);
      });
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }
 
 @override
  void didPopNext() {
    super.didPopNext();
   cityList = localdatabase.getData();
    if(cityList==null){  setState(() {  cityNameList = []; });  }
    else{
     cityNameList = cityList.map((indexItem){
         return jsonDecode(indexItem);
      }).toList();
      setState(() {
        print(cityNameList.length);
      });
    }

  }
 
 @override
  void dispose() {
  
    super.dispose();
    routeObserver.unsubscribe(this);
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
             
             actions: [
             PopupMenuButton(
              
              constraints:const BoxConstraints(maxWidth: 90,maxHeight: 60),
              icon: const Icon(Icons.more_vert,color: Colors.white,),
              position: PopupMenuPosition.under,
              itemBuilder: (context){
               return [
                  PopupMenuItem(
                  onTap: (){
                    localdatabase.deleteAllData();
                    Toasthelper.showFlutterToast("Data Deleted Successfully");
                    setState(() {
                      
                    });    
                  },
                  child:const Text("Delete All",style: TextStyle(fontSize: 15),)),
                 ] ;
               },
              ),
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
                          Navigator.pushNamed(context, AppRoutes.weatherScreen,
                          arguments: {
                            'cityname': cityNameList[index][DatabaseKeyConst.cityName]
                            });
                        },
                        child: Dismissible(
                          confirmDismiss: (direction) async{
                              return await showDialog(context: (context), 
                                builder: (contex){
                                  return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  contentPadding: const EdgeInsets.only(left: 25,top: 5,right: 25,bottom: 5),
                                    title:const Text("Delete",style: TextStyle(fontWeight: FontWeight.w500),),
                                    content: Text("Are you sure you want to delete this city?",style: TextStyle(
                                      fontSize: 18.sp
                                    ),),
                                    actions: [
                                      TextButton(
                                          style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2)
                                          )
                                          ),
                                          onPressed: () {
                                           cityNameList.removeAt(index);
                                            localdatabase.updateData(keyValue: DatabaseKeyConst.cityData, dataList: cityNameList);
                                            Navigator.pop(context);
                                          },
                                          child:Text("YES",style: TextStyle(color: Colors.red,fontSize: 16.sp),)
                                        ),
                        
                                      TextButton(
                                          style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2)
                                          ),
                                          padding: EdgeInsets.zero
                                          ),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: Text("NO",style: TextStyle(color: Colors.green,fontSize: 16.sp))
                                      
                                        ),
                                    
                                    ],
                                  );
                                }); 
                          },
                          key: ValueKey<String>(cityNameList[index][DatabaseKeyConst.cityName]),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 15.h),
                                child: SizedBox(
                                  width: double.infinity,
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
                                                  width: 185.w,
                                                  height: 144.3.h,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                              
                                                      Text(
                                                        '${cityNameList[index][DatabaseKeyConst.mainTemp]}°C',
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 26.sp,
                                                            color: Colors.yellow),
                                                      ),
                                        
                                                      Text("Feels Like ${cityNameList[index][DatabaseKeyConst.feelLikeTemp]}°C",style:TextStyle(fontSize: 14.sp,color: Colors.white)),
                              
                                                      SizedBox(height: 20.h,),
                                                      Row(
                                                        children: [
                                                        Image.asset(
                                                          ImageConst.minTempIc,
                                                          height: 18.h,
                                                        ),
                                                          
                                                        Text(
                                                          "Min.${cityNameList[index][DatabaseKeyConst.minTemp]}°C",
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: Colors.white),
                                                        ),
                              
                                                        SizedBox(
                                                        height: 20.h,
                                                        child: const VerticalDivider(color: Colors.white,
                                                        thickness: 1.5,
                                                        )),
                                                        Text(
                                                          "Max.${cityNameList[index][DatabaseKeyConst.maxTemp]}°C",
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: Colors.white),
                                                        ),],
                                                      ),
                              
                                                    SizedBox(height: 10.h,),
                              
                                                    Row(
                                                    
                                                      children: [
                                                        const Icon(Icons.location_on_outlined,color: Colors.greenAccent,),
                                                        Text(cityNameList[index][DatabaseKeyConst.cityName]+', '+cityNameList[index][DatabaseKeyConst.countryName] ,style:TextStyle(fontSize: 18.sp,color: Colors.white)),
                                                      ],
                                                    )   
                                                    ],
                                                  ),
                                                ),
                                              
                                                const Spacer(),
                              
                                                SizedBox(
                                                  // color: Colors.amber,
                                                  width: 130,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                      children: [
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        Image.asset(
                                                          WeatherImageHelper.weatherImagePath(skyCondition:cityNameList[index][DatabaseKeyConst.skyCondition]),
                                                          width: 80.h,
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                                                              
                                                        const SizedBox(height: 5,),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 8),
                                                        child: Text(cityNameList[index][DatabaseKeyConst.skyCondition],style:TextStyle(fontSize: 18.sp,color: Colors.white)),
                                                      ),
                                                      ],
                                                    ),
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
                              Positioned(
                                right: 0,
                                top: 5,
                                child: PopupMenuButton(
                                                
                                  constraints:const BoxConstraints(maxWidth: 100,maxHeight: 60),
                                  icon: const Icon(Icons.more_vert,color: Colors.white,),
                                  position: PopupMenuPosition.under,
                                  itemBuilder: (context){
                                    return [
                                      PopupMenuItem(
                                    
                                      onTap: (){
                                        Toasthelper.showFlutterToast("Data Deleted Successfully");
                                        setState(() {
                                          
                                        });    
                                      },
                                      child:const Text("Delete City",style: TextStyle(fontSize: 15),)),
                                      ] ;
                                    },
                                  ),
                              ),
                              
                                          
                                             
                               ],
                           ),
                        ),
                      );
                },
              ),

          
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
            //final argument = await Navigator.pushNamed(context,AppRoutes.searchScreen);
        
            Navigator.pushNamed(context,AppRoutes.searchScreen);  // if(argument == null){
              //   return ;
              // }
              // else{
              //   cityNameRecieved = argument.toString();
              //   if(cityNameRecieved.isEmpty) { return; }
              //   else{
              //   setState(() {
              //   cityNameList.add(cityNameRecieved[0].toUpperCase()+cityNameRecieved.substring(1));
              //   },);
              //   }
              // } 
            },
            child: const Icon(Icons.add,
            color: Colors.yellow,
            ),
            ),
        )
        
    );
  
  }

  
}
