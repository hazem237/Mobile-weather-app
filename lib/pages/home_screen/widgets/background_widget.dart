import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter_app/provider.dart';

Widget buildBackground(BuildContext context) {
  final selectedCityProvider = Provider.of<SelectedCityProvider>(context);
  String backgroundImage =
      'lib/assets/default_background.jpg'; // Default background image

  // Map city names to corresponding image paths
  Map<String, String> cityImages = {
    'Jerusalem': 'lib/assets/Jerusalem.jpg',
    'Cairo': 'lib/assets/Cairo.jpg',
    'Beirut': 'lib/assets/Beirut.jpg',
    'Amman': 'lib/assets/Amman.jpg',
    'Riyadh': 'lib/assets/Riyadh.jpg',
  };

  // Check if the selected city has a corresponding image path
  if (cityImages.containsKey(selectedCityProvider.selectedCity)) {
    backgroundImage = cityImages[selectedCityProvider.selectedCity]!;
  }

  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(backgroundImage),
        fit: BoxFit.cover,
      ),
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        color: Colors.black.withOpacity(0.4),
      ),
    ),
  );
}
