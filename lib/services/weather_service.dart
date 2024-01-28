import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';

class WeatherService {
  static const BASE_URL = "http://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async{
    // final Dio dio = Dio();
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
    
    if(response.statusCode == 200){
      // print(response.body);
      return Weather.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load weather data');
    }
  }


  Future<String> getCurrentCity() async{

    // Get Location permission from user :
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    // Fetch the current Location :
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    // convert the location data into a list of place-mark Objects :
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    // Extract the CityName from the first place-mark :
    String? city = placemarks[0].locality;

    return city ?? "";

  }
}