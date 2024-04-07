import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/weather_model.dart';
import 'package:lottie/lottie.dart';
import '../service/weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _weatherService = WeatherService('b5f1a2924b259b5242811d3cfb8b5c60');
  Weather? _weather;
  _featchWeather() async {
    print('start');
    String cityName = await _weatherService.getCurrentCity();
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }
  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) {
      return 'assets/sunny.json';
    }
    switch(mainCondition.toLowerCase()) {
      case 'rain':
        return 'assets/rain.json';
      case 'clouds':
        return 'assets/cloud.json';
      case 'snow':
        return 'assets/snow.json';
      case 'thunderstorm':
        return 'assets/thunderstorm.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _featchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Weather',
          style: TextStyle(
            color: Colors.blue[200],
            letterSpacing: 2.0
          )
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(25, 118, 210, 1),
              Color.fromRGBO(30, 136, 229, 1),
              Color.fromRGBO(144, 202, 249, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _weather?.cityName ?? 'Load city ...',
                style: TextStyle(
                  fontSize: 36,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.blue[200],
                ),
              ),
              SizedBox(height: 40.0,),
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              Text(
                '${_weather?.temperature.round()} °C',
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[100],
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                _weather?.mainCondition ?? '',
                style: TextStyle(
                  fontSize: 24,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[100],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}