class ApiUrlConst {
  static const String apiKey = "a14e6dfcf36384aed661d1131ac9eba2";
  static const String apikey1= "AIzaSyBxnfKzMVmfehDP1B0ScIl0wXfKO7XX64U";
  
  //! common url 
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/";
  static const String placeLatLongUrl ="https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input={cityname}&inputtype=textquery&fields=geometry&key={ApiKey}";

  static const String suggestionPlaceUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input={USER_INPUT}&key=YOUR_API_KEY";
  static const String placeDetailUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id={PLACE_ID}&key=YOUR_API_KEY";


  // ignore: prefer_interpolation_to_compose_strings
  static const String weatherUrl = baseUrl + "weather?";
  static const String forecastUrl = '$baseUrl'"forecast?";

}