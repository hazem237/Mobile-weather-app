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
      appBar: buildAppBar(),
      drawer: AppDrawer(),
      body: Container(
        // color: Color.fromARGB(255, 212, 212, 212), // Set your desired background color here
        child: weatherDataList != null
            ? ListView.builder(
                itemCount: weatherDataList.length,
                itemBuilder: (context, index) {
                  return CityCard(weatherData: weatherDataList[index]);
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
