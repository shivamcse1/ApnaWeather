
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasthelper {

   static showFlutterToast(String message){
   
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color(0xFF331868),
        textColor: Colors.white,
        fontSize: 16.0,
        
    );

   }

}