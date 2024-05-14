import 'package:flutter/material.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/theme_page.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: screenPickerColor,
    secondary: Colors.green.shade600,
    inversePrimary: Colors.grey.shade800,
  ),
  textTheme: ThemeData.light()
      .textTheme
      .apply(bodyColor: Colors.grey[800], displayColor: Colors.black),
);
