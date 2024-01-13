// app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(

    primaryColor: Colors.blue, // Set your primary color
    // Set your accent color
    fontFamily: 'Roboto', // Set your preferred font
    // Add more styling properties as needed
  );

  // You can define a dark theme as well if needed
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    // Customize dark theme properties
  );
}
