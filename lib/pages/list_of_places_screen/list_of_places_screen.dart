import 'package:flutter/material.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';
import 'package:weather_flutter_app/services/current_weather_service.dart';

class ListOfPlacesScreen extends StatefulWidget {
  final List<String> cityNames;

  const ListOfPlacesScreen({required this.cityNames});

  @override
  _ListOfPlacesScreenState createState() => _ListOfPlacesScreenState();
}

class _ListOfPlacesScreenState extends State<ListOfPlacesScreen> {
  late List<WeatherData> weatherDataList;

  @override
  void initState() {
    super.initState();
    fetchWeatherForCities();
  }

  Future<void> fetchWeatherForCities() async {
    List<WeatherData> data = [];
    for (String city in widget.cityNames) {
      try {
        final weatherData = await WeatherService().fetchWeatherData(city);
        data.add(weatherData);
      } catch (e) {
        print('Error fetching weather for $city: $e');
        // Handle error for this city
      }
    }
    setState(() {
      weatherDataList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Places'),
      ),
      drawer: AppDrawer(),
      body: weatherDataList != null
          ? ListView.builder(
              itemCount: weatherDataList.length,
              itemBuilder: (context, index) {
                return CityCard(weatherData: weatherDataList[index]);
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

// Update the CityCard widget to accept WeatherData
class CityCard extends StatelessWidget {
  final WeatherData weatherData;

  const CityCard({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(weatherData.city),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${weatherData.temperature.toString()}°C'),
          Row(
            children: [
              Text(weatherData.weatherCondition),
              const SizedBox(width: 30),
              Image.network(
                'https:${weatherData.icon}',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
