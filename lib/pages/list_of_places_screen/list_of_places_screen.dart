import 'package:flutter/material.dart';
import 'package:weather_flutter_app/shared_widgets/drawer.dart';

class ListOfPlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Places Screen'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('List of Places Screen'),
      ),
    );
  }
}
