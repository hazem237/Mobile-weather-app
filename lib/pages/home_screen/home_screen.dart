import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter_app/provider.dart';
import 'package:weather_flutter_app/services/current_weather_service.dart';
import 'package:weather_flutter_app/shared_widgets/app_bar_widget.dart';
import 'package:weather_flutter_app/pages/home_screen/widgets/background_widget.dart';
import 'package:weather_flutter_app/pages/home_screen/widgets/weather_info_widget.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedCityProvider>(
      builder: (context, selectedCityProvider, _) {
        final WeatherService weatherService = WeatherService();
        final String selectedCity = selectedCityProvider.selectedCity;
        final String selectedImagePath = selectedCityProvider.selectedImagePath;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: buildAppBar('Home'),
          drawer: AppDrawer(),
          body: FutureBuilder<WeatherData>(
            future: weatherService.fetchWeatherData(selectedCity),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    buildBackground(context, selectedImagePath),
                    buildWeatherInfo(snapshot.data!),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error fetching weather: ${snapshot.error}'),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
