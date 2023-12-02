import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter_app/pages/city_hourly_weather_screen/hour_card.dart';
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
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'City : $cityName',
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
                      return HourlyWeatherCard(weatherData: weatherData);
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
