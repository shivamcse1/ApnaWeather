class ApiUrlConst {
  static const String apiKey = "a14e6dfcf36384aed661d1131ac9eba2";
  
  //! common url 
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/";
  // ignore: prefer_interpolation_to_compose_strings
  static const String weatherUrl = baseUrl + "weather?";
  static const String forecastUrl = '$baseUrl'"forecast?";

}