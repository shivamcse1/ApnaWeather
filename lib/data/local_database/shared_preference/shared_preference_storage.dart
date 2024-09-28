import 'package:shared_preferences/shared_preferences.dart';

class LocalDataBasePrefs {

 late SharedPreferences localDataBasePrefs;
 Future init() async{
   localDataBasePrefs = await SharedPreferences.getInstance();
 }
 
 //------------create or insert data in the local Storage-------------//
 void setData(List<String>dataList,String keyValue){
   localDataBasePrefs.setStringList(keyValue,dataList );

 }

  //------------Read data from local Storage-------------//
  List<String>? getData (String keyValue) {
   return localDataBasePrefs.getStringList(keyValue);
  }

  //------------ Update Data in Local storage ------------//
  
  void updateData (String keyValue,List<String>dataList ){
     localDataBasePrefs.setStringList(keyValue,dataList);
  }

  //------------ Delete Data in Local storage ------------//
  void deleteData (String keyValue) {
    localDataBasePrefs.remove(keyValue);
  }

}