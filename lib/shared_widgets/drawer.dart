import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Weather App Menu'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Home Screen'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: Text('List of Places Screen'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/listOfPlaces');
            },
          ),
          ListTile(
            title: Text('City Detailed Weather Screen'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/cityDetailedWeather');
            },
          ),
          ListTile(
            title: Text('City Hourly Weather Screen'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/cityHourlyWeather');
            },
          ),
        ],
      ),
    );
  }
}
