import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    scaffoldBackgroundColor: Color(0xFF121212),
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.dark(
        background: Color(0xFF1E1E1E),
        brightness: Brightness.dark,
        primary: Colors.grey.shade800,
        secondary: Colors.grey.shade600,
        tertiary: Colors.grey.shade500,
        inversePrimary: Colors.grey.shade800,
    ),
    appBarTheme: AppBarTheme(
        color: Color(0xFF1E1E1E),
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
        ),
    ),
);