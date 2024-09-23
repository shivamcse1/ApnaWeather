import 'package:shared_preferences/shared_preferences.dart';

class LocalSharedPrefrence {

 
 //------------create or insert data in the local Storage-------------//
 Future<void> setData(List<String>dataList,String fieldValue) async{
  SharedPreferences localDataBasePrefs = await SharedPreferences.getInstance() ;
  await localDataBasePrefs.setStringList(fieldValue,dataList );

 }


  //------------Read data from local Storage-------------//

  Future<List<String>?> getData (String fieldValue) async{
   SharedPreferences localDataBasePrefs = await SharedPreferences.getInstance() ;
   return localDataBasePrefs.getStringList(fieldValue);
  }

  //------------ Update Data in Local storage ------------//
  
  Future<void> updateData (String fieldValue,List<String>dataList ) async{
    SharedPreferences localDataBasePrefs = await SharedPreferences.getInstance();
    await localDataBasePrefs.setStringList(fieldValue,dataList);

  }

  //------------ Delete Data in Local storage ------------//
  
  Future<void> deleteData (String fieldValue) async{
    SharedPreferences localDataBasePrefs = await SharedPreferences.getInstance();
    await localDataBasePrefs.remove(fieldValue);

  }

}