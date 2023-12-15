import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_flutter_app/database/DatabaseHelper.dart';

class CitySelectionDropdown extends StatefulWidget {
  const CitySelectionDropdown({Key? key});

  @override
  _CitySelectionDropdownState createState() => _CitySelectionDropdownState();
}

class _CitySelectionDropdownState extends State<CitySelectionDropdown> {
  List<Map<String, dynamic>> cityDataList = [];

  Future<void> loadCitiesFromJson() async {
    try {
      final String response =
          await rootBundle.loadString('lib/assets/cities.json');
      List<dynamic> citiesJson = json.decode(response);

      setState(() {
        cityDataList = citiesJson.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      print('Error loading cities: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadCitiesFromJson();
  }

  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: const Text('Select a city'),
      value: selectedCity,
      onChanged: (String? cityName) async {
        setState(() {
          selectedCity = cityName;
        });

        if (cityName != null) {
          bool cityExists =
              await DatabaseProvider.instance.checkCityExists(cityName);
          if (!cityExists) {
            Map<String, dynamic>? selectedCityData = cityDataList.firstWhere(
              (element) => element['name'] == cityName,
            );
            if (selectedCityData != null) {
              try {
                int result = await DatabaseProvider.instance
                    .insertCity(selectedCityData);
                if (result != -1) {
                  print('City inserted: $cityName');
                } else {
                  print('Failed to insert city: $cityName');
                }
              } catch (e) {
                print('Error inserting city: $e');
              }
            } else {
              print('City data not found for $cityName');
            }
          } else {
            print('City $cityName already exists in the database');
          }
        }
      },
      items: cityDataList.map<DropdownMenuItem<String>>((cityData) {
        return DropdownMenuItem<String>(
          value: cityData['name'] as String,
          child: Text(cityData['name'] as String),
        );
      }).toList(),
    );
  }
}
