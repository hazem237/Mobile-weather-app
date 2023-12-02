import 'package:flutter/material.dart';
import 'package:weather_flutter_app/services/seven_hours_service.dart';

class HourlyWeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  const HourlyWeatherCard({
    required this.weatherData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, 
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https:${weatherData.currentConditionIcon}',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Time: ${weatherData.time}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Current Temp: ${weatherData.currentTempC}°C',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Condition: ${weatherData.currentConditionText}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
