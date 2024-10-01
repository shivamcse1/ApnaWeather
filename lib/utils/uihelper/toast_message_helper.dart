
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasthelper {

   static showFlutterToast(String message){
   
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Color.fromARGB(255, 202, 210, 208),
        textColor: Colors.black,
        fontSize: 16.0,
        
    );

   }

}