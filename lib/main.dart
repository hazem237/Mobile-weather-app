import 'package:flutter/material.dart';
import 'package:weather_flutter_app/pages/city_detailed_weather_screen/city_detailed_weather_screen.dart';
import 'package:weather_flutter_app/pages/city_hourly_weather_screen/city_hourly_weather_screen.dart';
import 'package:weather_flutter_app/pages/home_screen/home_screen.dart';
import 'package:weather_flutter_app/pages/list_of_places_screen/list_of_places_screen.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/listOfPlaces': (context) => ListOfPlacesScreen(),
        '/cityDetailedWeather': (context) => CityDetailedWeatherScreen(),
        '/cityHourlyWeather': (context) => CityHourlyWeatherScreen(),
      },
    );
  }
}
