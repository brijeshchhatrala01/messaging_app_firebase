import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/theme_page.dart';


//profile page
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.message,
            size: 72,
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: screenPickerColor,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: Text('${FirebaseAuth.instance.currentUser!.email}'),
            ),
          ),
        ],
      ),
    );
  }
}
