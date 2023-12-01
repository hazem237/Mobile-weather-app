import 'package:flutter/material.dart';

class SelectedCityProvider extends ChangeNotifier {
  late String _selectedCity = 'Jerusalem'; // Default city

  String get selectedCity => _selectedCity;

  void updateSelectedCity(String city) {
    _selectedCity = city;
    notifyListeners();
  }
}
