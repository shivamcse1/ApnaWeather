class ApiHeader {


 static Map<String,String> header(bool isRequireAuthorization){
    
    if(isRequireAuthorization){

      return {"Content-Type" : "application/json"};
    }else{

       return {"Content-Type" : "application/json"};
    }

  }
}