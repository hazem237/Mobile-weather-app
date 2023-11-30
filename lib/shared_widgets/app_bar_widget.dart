import 'package:flutter/material.dart';

PreferredSizeWidget? buildAppBar() {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(size: 40, color: Colors.white),
    leading: Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    title: const Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Text(
        'Home',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}
