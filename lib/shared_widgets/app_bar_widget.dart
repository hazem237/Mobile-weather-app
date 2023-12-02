import 'package:flutter/material.dart';

PreferredSizeWidget? buildAppBar(String page_title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: const IconThemeData(size: 40, color: Colors.white),
    leading: Builder(
      builder: (context) => IconButton(
        icon: const Icon(Icons.menu),
        color: const Color.fromARGB(255, 83, 83, 83),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    title: Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        page_title, 
        style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 44, 44, 44)),
      ),
    ),
  );
}
