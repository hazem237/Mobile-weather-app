import 'package:flutter/material.dart';
import 'package:weather_flutter_app/services/current_weather_service.dart';

Widget buildWeatherInfo(WeatherData weatherData) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kToolbarHeight), 
        Container(
          margin: const EdgeInsets.only(left: 20), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weatherData.city,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                '${weatherData.temperature.toString()}°C',
                style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    weatherData.weatherCondition,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  Image.network(
                    'https:${weatherData.icon}',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
