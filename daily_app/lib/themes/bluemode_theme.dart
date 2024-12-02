import 'package:flutter/material.dart';

ThemeData blueMode = ThemeData(
  scaffoldBackgroundColor: Color(0xFFE3F2FD),
  fontFamily: 'Poppins',
  colorScheme: ColorScheme.light(
    background: Color(0xFFBBDEFB),
    brightness: Brightness.light,
    primary: Colors.blue.shade500,
    secondary: Colors.blueAccent,
    tertiary: Colors.lightBlue,
    inversePrimary: Colors.blue.shade800,
  ),
  appBarTheme: AppBarTheme(
    color: Color(0xFFE3F2FD),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
);
