import 'package:flutter/material.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/theme_page.dart';

//Custom Button with icon
class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String buttonName;
  final IconData? iconData;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonName,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: screenPickerColor,
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                buttonName,
                style: const TextStyle(fontSize: 18, letterSpacing: 6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
