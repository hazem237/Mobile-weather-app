import 'dart:ui';
import 'package:flutter/material.dart';

Widget buildBackground() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('lib/assets/Jerusalem.jpg'),
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
