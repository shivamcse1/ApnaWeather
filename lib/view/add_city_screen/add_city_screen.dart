import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});

  @override
  State<AddCityScreen> createState() => AddCityScreenState();
}

class AddCityScreenState extends State<AddCityScreen> {
  TextEditingController locationController = TextEditingController();
  TextEditingController cityController  = TextEditingController();
  List<String> cityNameList = [];
  
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
            title:  Padding(
               padding: const EdgeInsets.only(bottom: 10,top: 10),
               child: Text("Pick Location",
               style: TextStyle(
                fontSize: 24.sp,
                color: Colors.yellow,
                fontWeight: FontWeight.bold),),
             ),  
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Find the city or area that you want to know the\n"
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

                  //-------------Search Part --------------//
                  Row(
                    children: [
                      Container(
                        height: 50.h,
                        width: 265.w,
                        decoration: BoxDecoration(
                            color: const Color(0xFF331868),
                            borderRadius: BorderRadius.circular(8.sp)),
                        child: TextFormField(
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                            controller: locationController,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 10.0.h, left: 20.w),
                                hintText: "Please Enter Your City",
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 14.sp),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.circular(8.0.sp)))),
                      ),
                     
                    Spacer(),
                     
                      Container(
                          height: 50,
                          width: 60.w,
                          decoration: BoxDecoration(
                              color: const Color(0xFF331868),
                              border: Border.all(
                                color: Colors.transparent
                              ),
                              borderRadius: BorderRadius.circular(8.sp)),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.location_on_outlined,
                                size: 28,
                                color: Colors.white,
                              ))),
                    ],
                  ),

                  SizedBox(
                    height: 30.h,
                  ),

                  //-------------Card Part  --------------//
                  ListView.builder(
                    itemCount: cityNameList.length,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: SizedBox(
                          width: 100,
                          child: Card(
                            margin: EdgeInsets.zero,
                            elevation: 5,
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
                                                  "assets/icons/min_temp2_ic.png",
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
                                                "assets/icons/cloud_ic.png",
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
            backgroundColor: const Color(0xFF331868),
            onPressed: (){
                showDialog(
                context: context, 
                  builder: (context){
                    return  AlertDialog(
                        title: const Text("Add Your City"),

                         content: TextFormField(
                          controller: cityController,
                          decoration: const InputDecoration(
                            hintText: "Enter City Name",
                          ),
                          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]'))],
                        
                        ),
                        actions: [
                          
                        TextButton(
                          onPressed:(){
                          Navigator.pop(context);
                          }, 
                          child: Text("Cancel",style: TextStyle(fontSize: 16.sp),)
                          ),
                        
                        TextButton(
                          onPressed:() {

                           cityNameList.add(cityController.text);
                           setState(() {
                              Navigator.pop(context);
                           });
                          
                          }, 
                          child: Text("Add",style: TextStyle(fontSize: 16.sp),)
                         ),
                        ],
                  
                    );
                    }
                  );
        

            },
            child: const Icon(Icons.add,
            color: Colors.yellow,
            ),
            ),
        )
        
    );
  }

  
}
