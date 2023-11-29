import 'package:flutter/material.dart';
import 'package:weather_flutter_app/shared_widgets/app_bar_widget.dart';
import 'package:weather_flutter_app/pages/home_screen/widgets/background_widget.dart';
import 'package:weather_flutter_app/pages/home_screen/widgets/weather_info_widget.dart';
import 'package:weather_flutter_app/services/current_weather_service.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  late WeatherData weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    try {
      final data = await _weatherService.fetchWeatherData('Jerusalem');
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print('Error fetching weather: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      drawer: AppDrawer(), //Found in lib/shared_widgets
      body: Stack(
        children: [
          buildBackground(), // Found in home_screen/widgets
          buildWeatherInfo(weatherData), // Found in home_screen/widgets
        ],
      ),
    );
  }
}
