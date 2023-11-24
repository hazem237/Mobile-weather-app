import 'package:flutter/material.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';

class CityDetailedWeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Detailed Weather Screen'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('City Detailed Weather Screen'),
      ),
    );
  }
}
