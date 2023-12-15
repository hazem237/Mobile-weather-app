import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:ui';

Widget buildBackground(BuildContext context, String imagePath) {
  return FutureBuilder<ImageProvider>(
    future: getImage(imagePath),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          color: Colors.black, 
        );
      } else if (snapshot.hasError) {
        return Container(
          color: Colors.red, 
        );
      } else {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: snapshot.data!,
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
    },
  );
}

Future<ImageProvider> getImage(String imagePath) async {
  final response = await http.get(Uri.parse(imagePath));
  if (response.statusCode == 200) {
    return MemoryImage(response.bodyBytes);
  } else {
    throw Exception('Failed to load image');
  }
}
