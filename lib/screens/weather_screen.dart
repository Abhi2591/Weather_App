import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  // Api key :
  final _weatherService = WeatherService('5e9df538a631292a28ba4a832f1e904b');
  Weather? _weather;

  // Fetch Weather :
  _fetchWeather() async{
    // Getting the current City :
    String cityName = await _weatherService.getCurrentCity();

    // Get weather data for the above city :
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }catch(e){
      print(e);
    }

  }

  // Weather Animations :
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null) return 'assets/sunny.json'; // default will be sunny weather

    switch (mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/partly-cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetch weather :
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // City Name :
            FittedBox(
              child: Column(
                children: [
                  const Icon(Icons.place,size: 35,color: Colors.white60,),
                  const SizedBox(height: 16,),
                  Text((_weather?.cityName)?.toUpperCase() ?? 'Loading city...',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),),
                ],
              ),
            ),

            // Animations :
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // Temperature :
            Text('${_weather?.temperature.round()}°C',
              style: GoogleFonts.fjallaOne(
                    fontSize: 40,
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  )
              ),
            
            // Main condition of weather :
            Text(_weather?.mainCondition ?? "",
            style: GoogleFonts.roboto(
              fontSize: 25,
              color: Colors.yellow[300],
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),)

          ],
        ),
      ),
    );
  }
}
