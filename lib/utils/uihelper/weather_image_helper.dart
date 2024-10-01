
import 'package:apna_weather_app/core/constants/image_const.dart';

class WeatherImageHelper{
  // weather Image Path Provider Function
  static String weatherImagePath({  String skyCondition = "Clear" }){
    DateTime now = DateTime.now();
    int hour = now.hour;

    switch(skyCondition){
       case 'Clear':
        if(hour<19 && hour >5) { return ImageConst.clearSkyDayImg; } 
        else { return ImageConst.clearSkyNightImg; }
       
       case  'Clouds':
        if(hour<19 && hour >5)
          { 
            return ImageConst.fewCloudsDayImg; } 
        else { return ImageConst.fewCloudsNightImg ;}

       case  'Haze':
        if(hour<19 && hour >5){ return ImageConst.hazeDayImg ; } 
        else { return ImageConst.hazeNightImg ;}

       case  'Rain':
        if(hour<19 && hour >5) { return ImageConst.rainDayImg; } 
        else { return ImageConst.rainNightImg;}

       case  'Thunderstorm':
        if(hour<19 && hour >5) { return ImageConst.thunderstormDayImg; } 
        else { return ImageConst.thunderstormNightImg;}

       case  'Snow':
        if(hour<19 && hour >5) { return ImageConst.snowImg; } 
        else { return ImageConst.snowImg;}

       case  'Mist':
        if(hour<19 && hour >5) { return ImageConst.mistDayImg; } 
        else { return ImageConst.mistNightImg;}
       
       default :
        if(hour<19 && hour >5) { return ImageConst.clearSkyDayImg; } 
        else { return ImageConst.clearSkyNightImg;}

    }
  }

   
  
  // weather Forecast Image Path Provider Function
  static String weatherForecastImagePath({  String skyCondition = "Clear Sky" , required int hour}){
     
    switch(skyCondition){
       case 'Clear':
        if(hour<19 && hour >5) { return ImageConst.forecastClearSkyDayIc; }
        else {return ImageConst.forecastClearSkyNightIc;}
        
       case  'Clouds':
        if(hour<19 && hour >5) { return ImageConst.forecastCloudsDayIc; }
        else {  return ImageConst.forecastCloudsNightIc;}
    
       case  'Rain':
        if(hour<19 && hour >5) {return ImageConst.forecastRainDayIc; }
        else  {return ImageConst.forecastRainNightIc;}

       case 'Thunderstorm':
        if(hour<19 && hour >5) { return ImageConst.forecastThunderStromDaytIc; } 
        else { return ImageConst.forecastThunderStromNightIc;}

       case 'Haze':
        if(hour<19 && hour >5) { return ImageConst.forecastHazeDayIc; } 
        else { return ImageConst.forecastHazeNightIc;}

       case  'Snow':
        if(hour<19 && hour >5) { return ImageConst.forecastSnowDayIc; } 
        else { return ImageConst.forecastSnowNightIc;}

       case  'Mist':
        if(hour<19 && hour >5) { return ImageConst.forecastMistDayIc; } 
        else { return ImageConst.forecastMistNightIc;}
       
       default :
        if(hour<19 && hour >5) { return ImageConst.forecastClearSkyDayIc; } 
        else { return ImageConst.forecastClearSkyNightIc;}
        
    }
  }

}