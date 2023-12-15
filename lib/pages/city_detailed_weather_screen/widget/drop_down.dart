import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CitySelectionDropdown extends StatefulWidget {
  const CitySelectionDropdown({super.key});

  @override
  _CitySelectionDropdownState createState() => _CitySelectionDropdownState();
}

class _CitySelectionDropdownState extends State<CitySelectionDropdown> {
  List<String> cityNames = [];

  Future<void> loadCitiesFromJson() async {
    try {
      final String response =
          await rootBundle.loadString('lib/assets/cities.json');
      List<dynamic> citiesJson = json.decode(response);

      setState(() {
        cityNames = citiesJson.map((city) => city['name'].toString()).toList();
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
      onChanged: (String? cityName) {
        setState(() {
          selectedCity = cityName;
        });
      },
      items: cityNames.map<DropdownMenuItem<String>>((String cityName) {
        return DropdownMenuItem<String>(
          value: cityName,
          child: Text(cityName),
        );
      }).toList(),
    );
  }
}
