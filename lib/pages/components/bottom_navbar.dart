import 'package:flutter/material.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/theme_page.dart';

//bottom navigation bar
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;
  const CustomBottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        selectedItemColor: screenPickerColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "H O M E"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "P R O F I L E"),
          BottomNavigationBarItem(
              icon: Icon(Icons.color_lens), label: "T H E M E"),
          BottomNavigationBarItem(icon: Icon(Icons.messenger),label: 'M E S S A G E'),
        ]);
  }
}
