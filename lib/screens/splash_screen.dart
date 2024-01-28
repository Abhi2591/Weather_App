import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openNextPage();
  }
  
  void openNextPage(){
    Future.delayed(const Duration(seconds: 2),() {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => const WeatherScreen(),
      ));
    },);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset('assets/weather-app.png',fit: BoxFit.fill,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
