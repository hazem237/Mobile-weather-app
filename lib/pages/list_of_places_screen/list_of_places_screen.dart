import 'package:flutter/material.dart';
import 'package:weather_flutter_app/pages/list_of_places_screen/widgets/city_card.dart';
import 'package:weather_flutter_app/shared_widgets/app_bar_widget.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';
import 'package:weather_flutter_app/services/current_weather_service.dart';

class ListOfPlacesScreen extends StatefulWidget {
  final List<String> cityNames;

  const ListOfPlacesScreen({required this.cityNames});

  @override
  _ListOfPlacesScreenState createState() => _ListOfPlacesScreenState();
}

class _ListOfPlacesScreenState extends State<ListOfPlacesScreen> {
  late Future<List<WeatherData>> _weatherDataFuture;

  @override
  void initState() {
    super.initState();
    _weatherDataFuture = fetchWeatherForCities();
  }

  Future<List<WeatherData>> fetchWeatherForCities() async {
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
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: AppDrawer(),
      body: FutureBuilder<List<WeatherData>>(
        future: _weatherDataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CityCard(weatherData: snapshot.data![index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
