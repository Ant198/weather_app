import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_application_1/model/weather_model.dart';
import 'package:http/http.dart' as http;
class WeatherService {
  final String BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather>getWeather(String cityName) async{
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
    if(response.statusCode == 200) {
      print(response.body);
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error');
    }
  }

  Future<String>getCurrentCity() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    List <Placemark> placemarks = await placemarkFromCoordinates(/*position.latitude*/49.439780, /*position.longitude*/ 32.098543);
    print(placemarks);
    String? city = placemarks[0].locality;

    return city ?? '';
  }
}