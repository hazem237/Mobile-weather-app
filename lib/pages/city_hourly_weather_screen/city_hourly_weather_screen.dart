import 'package:flutter/material.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';

class CityHourlyWeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City Hourly Weather Screen'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('City Hourly Weather Screen'),
      ),
    );
  }
}
