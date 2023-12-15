import 'package:flutter/material.dart';

class SelectedCityProvider extends ChangeNotifier {
  late String _selectedCity = 'Jerusalem';
  late String _selectedImagePath = 'https://media.istockphoto.com/id/1351253013/photo/western-wall-at-the-dome-of-the-rock-on-the-temple-mount-in-jerusalem-israel.webp?b=1&s=170667a&w=0&k=20&c=v4-AJgQbuo5NPwaaW226Xab-HwEaquIupWJ8ykFq37k=';

  String get selectedCity => _selectedCity;
  String get selectedImagePath => _selectedImagePath;

  void updateSelectedCity(String city, String imagePath) {
    print('from provider $city $imagePath');
    _selectedCity = city;
    _selectedImagePath = imagePath;
    notifyListeners();
  }
}
