import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter_app/provider.dart';
import 'package:weather_flutter_app/shared_widgets/app_bar_widget.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';
import 'package:weather_flutter_app/services/seven_hours_service.dart';

class CityHourlyWeatherScreen extends StatelessWidget {
  const CityHourlyWeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedCityProvider = Provider.of<SelectedCityProvider>(context);
    final cityName = selectedCityProvider.selectedCity; 

    return Scaffold(
      appBar: buildAppBar('Upcoming hours'),
      drawer: AppDrawer(),
      body: FutureBuilder<List<WeatherData>>(
        future: WeatherService().fetchWeather(cityName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final weatherDataList = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$cityName',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: weatherDataList.length,
                    itemBuilder: (context, index) {
                      final weatherData = weatherDataList[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
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
                                  Text('Time: ${weatherData.time}'),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Current Temp: ${weatherData.currentTempC}°C',
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Condition: ${weatherData.currentConditionText}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: Text('No data available.'),
            );
          }
        },
      ),
    );
  }
}
