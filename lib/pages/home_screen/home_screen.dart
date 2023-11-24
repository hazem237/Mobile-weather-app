import 'package:flutter/material.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
