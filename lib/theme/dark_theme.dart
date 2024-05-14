import 'package:flutter/material.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/theme_page.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: screenPickerColor,
    secondary: Colors.green.shade600,
    inversePrimary: Colors.grey.shade300,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Colors.grey[300],
        displayColor: Colors.white,
      ),
);
