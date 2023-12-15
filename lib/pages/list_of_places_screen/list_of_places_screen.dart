import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter_app/pages/city_detailed_weather_screen/widget/drop_down.dart';
import 'package:weather_flutter_app/provider.dart';
import 'package:weather_flutter_app/services/current_weather_service.dart';
import 'package:weather_flutter_app/pages/list_of_places_screen/widgets/city_card.dart';
import 'package:weather_flutter_app/shared_widgets/app_bar_widget.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';

class ListOfPlacesScreen extends StatefulWidget {
  final List<String> cityNames;

  const ListOfPlacesScreen({super.key, required this.cityNames});

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
      }
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('List of places'),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CitySelectionDropdown(),
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
                          selectedCityProvider
                              .updateSelectedCity(widget.cityNames[index]);
                          Navigator.pop(context);
                        },
                        child: CityCard(weatherData: snapshot.data![index]),
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
