import 'package:flutter/material.dart';
import 'package:weather_flutter_app/services/seven_days_weather.dart';

class DayCard extends StatelessWidget {
  final WeatherData weatherData;
  final int index;

  const DayCard({Key? key, required this.weatherData, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add a shadow to the card
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Row(
                children: [
                  Text(
                    '${index == 0 ? 'Tomorrow' : 'Day ${index + 1}'}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.network(
                    'https:${weatherData.currentConditionIcon}',
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
              Text(
                '${weatherData.forecastConditionText}',
                style: const TextStyle(fontSize: 16),
              ),

            ]),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 8),
                Text(
                  '${weatherData.currentTempC}°C',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Max: ${weatherData.maxTempC}°C',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Min: ${weatherData.minTempC}°C',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
