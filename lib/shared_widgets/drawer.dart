import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  Widget _buildDrawerHeader() {
    return const DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/drawerBackground.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: null,
    );
  }

  Widget _buildDrawerItem(
      IconData icon, String title, Function() onTap, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(),
          _buildDrawerItem(Icons.home, 'Home ', () {
            Navigator.pushNamed(context, '/');
          }, context),
          _buildDrawerItem(Icons.location_city, 'List of Places ', () {
            Navigator.pushNamed(context, '/listOfPlaces');
          }, context),
          _buildDrawerItem(Icons.cloud, 'City Detailed Weather ', () {
            Navigator.pushNamed(context, '/cityDetailedWeather');
          }, context),
          _buildDrawerItem(Icons.access_time, 'City Hourly Weather ', () {
            Navigator.pushNamed(context, '/cityHourlyWeather');
          }, context),
        ],
      ),
    );
  }
}
