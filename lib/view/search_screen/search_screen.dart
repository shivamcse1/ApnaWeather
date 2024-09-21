import 'package:apna_weather_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
 
 const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  TextEditingController cityNameController = TextEditingController();
  double fullwidth = double.infinity;
  bool isTap = false;
  List<String> topCity = [
  "New Delhi",
  "Kanpur",
  "Sitapur",
  "Mumbai" ,
  "Kolkata",
  "Lucknow",
  "Pune",
  "Chennai",
  "Bengaluru",
  "Meerut",
  "Varanasi",
  "Patna",
  "Bhopal",
  "Chandigarh",
  "Cherrapunji",
  "Jammu"
  ];

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
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          toolbarHeight: 40,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            "Add Your City",
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.yellow,
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //-------------Search Part --------------//
              Container(
                height: 50.h,
                width: fullwidth,
                decoration: BoxDecoration(
                    color: const Color(0xFF331868),
                    borderRadius: BorderRadius.circular(8.sp)),
                child: TextFormField(
                     onFieldSubmitted: (inputValue){

                      showDialog(context: context, 
                      builder: (context){
                        return AlertDialog(
                          title: Text("Do You Want To Add City",
                          style: TextStyle(fontSize: 15.sp)
                          ),
                          actionsPadding: const EdgeInsets.only(bottom: 5,right: 15),
                          actions: [

                           TextButton(
                            onPressed:(){
                             Navigator.pop(context);
                             Navigator.pop(context,"null");
                             Navigator.pushNamed(context, AppRoutes.weatherScreen,arguments: inputValue);
                             
                            }, 
                            child: Text("No",style: TextStyle(fontSize: 15.sp),)
                            ),
                          
                           TextButton(
                            onPressed:() {

                              Navigator.pop(context);
                              Navigator.pop(context, inputValue);
                              Navigator.pushNamed(context, AppRoutes.weatherScreen,arguments: inputValue);
                            }, 
                            child: Text("Yes",style: TextStyle(fontSize: 15.sp),)
                          ),
                          ],
                        );
                       });

                        cityNameController.clear();
                    },  
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(('[a-z A-Z]')))],
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    controller: cityNameController,
                    decoration: InputDecoration(
                    
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(top:3.2),
                        child: Icon(Icons.search,color: Colors.white,),
                      ),
                        contentPadding:
                            EdgeInsets.only(top: 3.0.h, left: 20.w),
                        hintText: "Please Enter Your City",
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 14.sp),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8.0.sp)))),
              ),

              SizedBox(height: 20.h,),

              Text("TOP CITIES",
              style: TextStyle(fontSize: 16.sp,color:Colors.white,fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.h,),

              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 90.w / 40.h
                  ),
                 itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: () {

                      showDialog(context: context, 
                      builder: (context){
                        return AlertDialog(
                          title: Text("Do You Want To Add City",
                          style: TextStyle(fontSize: 15.sp)
                          ),
                          actionsPadding: const EdgeInsets.only(bottom: 5,right: 15),
                          actions: [

                           TextButton(
                            onPressed:(){
                            //1st pop to current screen
                             Navigator.pop(context);

                            //2nd pop to previous screen
                             Navigator.pop(context,"null");
                             Navigator.pushNamed(context, AppRoutes.weatherScreen,arguments: topCity[index].trim());
                             
                            }, 
                            child: Text("No",style: TextStyle(fontSize: 15.sp),)
                            ),
                          
                           TextButton(
                            onPressed:() {
                              
                              //pop to current screen
                              Navigator.pop(context);

                              //Passing Data to previous Screen
                              Navigator.pop(context, topCity[index].trim());

                               // imediately move in next screen
                              Navigator.pushNamed(context, AppRoutes.weatherScreen,arguments: topCity[index].trim());
                            }, 
                            child: Text("Yes",style: TextStyle(fontSize: 15.sp),)
                          ),
                          ],
                        );
                       });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
                        borderRadius: BorderRadius.circular(5),
                        // color: isTap? Colors.blue: Colors.transparent,
                      ),
                      child: Center(
                        child: Text(topCity[index],
                        style: const TextStyle(color: Colors.white),
                        )
                        ),
                    ),
                  );
                 },
                 itemCount: topCity.length,
                 
                 )
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
                  
              //     Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("New Delhi",
              //         style: TextStyle(color: Colors.white),
              //         )
              //         ),
              //     ),

                  
              //      Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("Kanpur",
              //         style: TextStyle(color: Colors.white),
              //         )
              //         ),
              //     ),

              //      Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("Mumbai",
              //           style: TextStyle(color: Colors.white),
              //         )
              //         ),
              //     ),

              //      Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("Kolkata",
              //           style: TextStyle(color: Colors.white),
              //         )
              //         ),
              //     ),
              //   ],
              // ),
              //  SizedBox(height: 10.h,),
         
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
                  
              //     Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("Lucknow",
              //         style: TextStyle(color: Colors.white),
              //         )
              //         ),
              //     ),

                  
              //      Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("Pune",
              //         style: TextStyle(color: Colors.white),
              //         )
              //         ),
              //     ),

              //      Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("Chennai",
              //           style: TextStyle(color: Colors.white),
              //         )
              //         ),
              //     ),

              //      Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("Bengaluru",
              //           style: TextStyle(color: Colors.white),
              //         )
              //         ),
              //     ),
                   

              //   ],
              // ),
              //  SizedBox(height: 10.h,),
               
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
                  
              //     Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("Hyderabad",
              //         style: TextStyle(color: Colors.white),
              //         )
              //         ),
              //     ),

                  
              //      Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("Meerut",
              //         style: TextStyle(color: Colors.white),
              //         )
              //         ),
              //     ),

              //      Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("Jaipur",
              //           style: TextStyle(color: Colors.white),
              //         )
              //         ),
              //     ),

              //      Container(
              //       height: 30.h,
              //       width: 80.w,
              //       decoration: BoxDecoration(
              //         border: Border.all(color: const Color.fromARGB(255, 212, 114, 147)),
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       child: const Center(
              //         child: Text("Varanasi",
              //           style: TextStyle(color: Colors.white),
              //         )
              //       ),
              //     ),
                   

              //   ],
              // ),
         
            ],
          ),
        ),
      ),
    );
  }
}
