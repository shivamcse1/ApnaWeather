import 'package:apna_weather_app/core/routes/app_routes.dart';
import 'package:apna_weather_app/data/services/api_services.dart';
import 'package:apna_weather_app/utils/circular_loading_indicator.dart';
import 'package:apna_weather_app/utils/city_not_found.dart';
import 'package:apna_weather_app/utils/uihelper/toast_message_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  TextEditingController placeNameController = TextEditingController();
  List placeList =[];
  String enterdText='';
  bool isLoading = false;
  bool isTap = false;

  @override
  Widget build(BuildContext context) {
    return  Container(
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
            title:  Text("Search Location",
            style: TextStyle(
             fontSize: 20.sp,
             color: Colors.yellow,
             fontWeight: FontWeight.w500),),  
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                 
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

                //-------------Search Bar --------------//
                Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                color: const Color(0xFF331868),
                borderRadius: BorderRadius.circular(8.sp)),
                child: TextFormField(
                     
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(('[a-z A-Z]')))],
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    controller: placeNameController,
                    decoration: InputDecoration(
                    suffixIcon: placeNameController.text.isNotEmpty 
                     ? Padding(
                      padding: const EdgeInsets.only(left: 13,right: 5,top: 10,bottom: 10),
                      child: CircleAvatar(
                        
                        backgroundColor: const Color.fromARGB(255, 70, 48, 114),
                        child: IconButton(onPressed: (){
                           placeNameController.clear();
                           setState(() {
                             enterdText='';
                             placeList.clear();
                             isLoading= false;
                           });
                        }, 
                        
                        icon: const Icon(Icons.close,
                        color: Colors.white,
                        size: 15,
                        ),
                        ),
                      ),
                     )
                     : const SizedBox(),
                    prefixIcon: const Padding(
                    padding: EdgeInsets.only(top:3.2),
                    child: Icon(Icons.search,color: Colors.white,),
                    ),
                    contentPadding:
                        EdgeInsets.only(top: 3.0.h, left: 20.w),
                    hintText: "Enter Place Name",
                    hintStyle:
                        TextStyle(color: Colors.white, fontSize: 14.sp),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0.sp))
                        ),

                        onChanged: (inputValue)async {
                          setState(() {
                                enterdText = inputValue;

                                if(enterdText.isEmpty){
                                  placeList.clear();
                                  isLoading=false;
                                }
                            });
                        },
                        onFieldSubmitted: (inputValue) async{
                          if(inputValue.isEmpty) {
                            Toasthelper.showFlutterToast("Please Enter Place Name");
                            return;
                          }
                          setState(() {
                          isLoading = true;
                          isTap = true;
                          });

                          placeList =  await ApiServices.getSuggestedPlace(place: inputValue);
                          setState(() {

                             isTap = false;
                          });
                          }
                        ),
                      ),
                 
                  SizedBox(height: 20.h,),
                  enterdText.isNotEmpty && isLoading==false
                  ? Text("Please Tap Enter To Search Online",
                    style: TextStyle(fontSize: 16.sp,color: Colors.white),
                    )  
                  : const SizedBox(),

                  //-------------Suggestion Place Part  --------------//
                  isTap ? SizedBox(
                  height: 470.h,
                  child: Center(child: circularLoading( color: Colors.yellow)))
                  : isLoading && placeList.isEmpty && enterdText.isNotEmpty ? cityNotFound(h: 470,msg: "Oops! No Place Found")
                  :Visibility(
                    visible: placeList.isNotEmpty,
                     child: ListView.builder(
                      itemCount: placeList.length,
                      padding: EdgeInsets.zero,
                      
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async{
                          final placeId= placeList[index]['place_id'];
                         
                          // hit getLatLong Api Using Place ID
                          final latLongData = await ApiServices.getLatLongByPlaceID(placeID: placeId);
                          final lat = latLongData["result"]["geometry"]['location']['lat'];
                          final long = latLongData["result"]["geometry"]['location']['lng'];
                          final placeName = placeList[index]['structured_formatting']['main_text'];
                          
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, AppRoutes.weatherScreen,arguments:{
                            'lat' :lat,
                            'long' : long,
                            'place_name':placeName,
                          });
                          
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF331868),
                              borderRadius: BorderRadius.circular(8.0)
                            ),
                            child: ListTile(
                            contentPadding:const EdgeInsets.only(left: 5),
                            leading:const Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: CircleAvatar(
                                maxRadius:20,
                                backgroundColor: Color.fromARGB(255, 70, 48, 114),
                                child: Icon(Icons.location_on,color: Colors.white,)),
                            ),
                          
                            title: Text(placeList[index]['structured_formatting']['main_text'].toString(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              ),),
                            subtitle: Text(placeList[index]['structured_formatting']['secondary_text'].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              ),
                            ), 
                           ),
                           ),
                        );
                      },
                    ),
                   )
             
                ],
              ),
            ),
          ),
       
        )
        
    );
  
  }
}