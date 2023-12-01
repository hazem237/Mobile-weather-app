import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter_app/services/seven_days_weather.dart'; // Replace with your WeatherService file import
import 'package:weather_flutter_app/shared_widgets/drawer.dart';
import 'package:weather_flutter_app/provider.dart';

class CityDetailedWeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selectedCityProvider = Provider.of<SelectedCityProvider>(context);
    final cityName = selectedCityProvider.selectedCity; // Get the selected city

    return Scaffold(
      appBar: AppBar(
        title: Text('City Detailed Weather Screen'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<WeatherData>>(
        future: WeatherService().fetchWeather(cityName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final weatherDataList = snapshot.data!;
            return ListView.builder(
              itemCount: weatherDataList.length,
              itemBuilder: (context, index) {
                final weatherData = weatherDataList[index];
                return Card(
                  child: ListTile(
                    title: Text('Day ${index + 1}: ${weatherData.cityName}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Max Temp: ${weatherData.maxTempC}°C'),
                        Text('Min Temp: ${weatherData.minTempC}°C'),
                        Text('Condition: ${weatherData.forecastConditionText}'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: Text('No data available.'),
            );
          }
        },
      ),
    );
  }
}
