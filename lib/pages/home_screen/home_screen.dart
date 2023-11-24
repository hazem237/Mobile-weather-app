import 'package:flutter/material.dart';
import 'package:weather_flutter_app/services/current_weather_service.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();

  WeatherData? weatherData;

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: weatherData != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 weatherData!.icon.isNotEmpty
                      ? SizedBox(
                          width: 120, 
                          height: 120, 
                          child: Image.network(
                            'https:${weatherData!.icon}',
                            fit: BoxFit.contain, 
                          ),
                        )
                      : const Text('Weather Icon Not Available'),
                  Text('City: ${weatherData!.city}'),
                  Text('Temperature: ${weatherData!.temperature}°C'),
                  Text('Weather Condition: ${weatherData!.weatherCondition}'),
                ],
              )
            : const Text("Oops, current weather is not available"),
      ),
    );
  }
}
