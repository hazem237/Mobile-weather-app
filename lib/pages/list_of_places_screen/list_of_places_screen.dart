import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter_app/database/DatabaseHelper.dart';
import 'package:weather_flutter_app/database/models/city.dart';
import 'package:weather_flutter_app/pages/list_of_places_screen/widgets/drop_down.dart';
import 'package:weather_flutter_app/provider.dart';
import 'package:weather_flutter_app/services/current_weather_service.dart';
import 'package:weather_flutter_app/pages/list_of_places_screen/widgets/city_card.dart';
import 'package:weather_flutter_app/shared_widgets/app_bar_widget.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';

class ListOfPlacesScreen extends StatefulWidget {
  ListOfPlacesScreen({super.key});

  @override
  _ListOfPlacesScreenState createState() => _ListOfPlacesScreenState();
}

class _ListOfPlacesScreenState extends State<ListOfPlacesScreen> {
  late Future<List<WeatherData>> _weatherDataFuture;
  List<String> cityNames = [];
  List<String> cityImages = [];

  @override
  void initState() {
    super.initState();
    _weatherDataFuture = fetchDataFromDatabase();
  }

  Future<List<WeatherData>> fetchWeatherForCities() async {
    List<WeatherData> data = [];

    for (String city in cityNames) {
      try {
        final weatherData = await WeatherService().fetchWeatherData(city);
        data.add(weatherData);
      } catch (e) {
        print('Error fetching weather for $city: $e');
      }
    }
    return data;
  }

  Future<List<WeatherData>> fetchDataFromDatabase() async {
    try {
      List<City> cities = await DatabaseProvider.instance.getCities();
      for (var city in cities) {
        if (!cityNames.contains(city.name)) {
          cityNames.add(city.name);
          cityImages.add(city.imagePath);
        }
      }
      return fetchWeatherForCities();
    } catch (e) {
      print('Error fetching cities: $e');
      return [];
    }
  }

  Future<void> updateData() async {
    setState(() {
      _weatherDataFuture = fetchDataFromDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('List of places'),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CitySelectionDropdown(),
              ElevatedButton(
                  onPressed: () {
                    updateData();
                  },
                  child: const Text('Update'))
            ],
          ),
          Expanded(
            child: FutureBuilder<List<WeatherData>>(
              future: _weatherDataFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          final selectedCityProvider =
                              Provider.of<SelectedCityProvider>(context,
                                  listen: false);
                          selectedCityProvider.updateSelectedCity(
                              cityNames[index], cityImages[index]);
                          Navigator.pushNamed(context, '/');
                        },
                        child: CityCard(
                          weatherData: snapshot.data![index],
                          updateDataCallback: updateData,
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
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
