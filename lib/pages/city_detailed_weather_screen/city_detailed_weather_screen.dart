import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter_app/pages/city_detailed_weather_screen/widget/day_card.dart';
import 'package:weather_flutter_app/services/seven_days_weather.dart'; // Replace with your WeatherService file import
import 'package:weather_flutter_app/shared_widgets/app_bar_widget.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';
import 'package:weather_flutter_app/provider.dart';

class CityDetailedWeatherScreen extends StatelessWidget {
  const CityDetailedWeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCityProvider = Provider.of<SelectedCityProvider>(context);
    final cityName = selectedCityProvider.selectedCity; // Get the selected city

    return Scaffold(
      appBar: buildAppBar('Upcoming 7 Days'),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              '$cityName',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<WeatherData>>(
              future: WeatherService().fetchWeather(cityName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  final weatherDataList = snapshot.data!;
                  return ListView.builder(
                    itemCount: weatherDataList.length,
                    itemBuilder: (context, index) {
                      final weatherData = weatherDataList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: DayCard(weatherData: weatherData, index: index),
                      );
                    },
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
          ),
        ],
      ),
    );
  }
}
