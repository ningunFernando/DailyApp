import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: Color(0xFFf2f3ed),
  fontFamily: 'Poppins',
  colorScheme: ColorScheme.light(
    background: Colors.yellow.shade50,
    brightness: Brightness.light,
    primary: Colors.green.shade500,
    secondary: Colors.green,
    tertiary: Colors.green,
    inversePrimary: Colors.green,
  ),
  appBarTheme: AppBarTheme(
color: Color(0xFFf2f3ed),
  iconTheme: IconThemeData(color: Colors.black),
  titleTextStyle: TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),
);