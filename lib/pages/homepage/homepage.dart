import 'package:flutter/material.dart';
import 'package:messaging_app/pages/MessageHTTP/message_http.dart';
import 'package:messaging_app/pages/components/bottom_navbar.dart';
import 'package:messaging_app/pages/components/nav_drawer.dart';
import 'package:messaging_app/pages/login/loginpage.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/theme_page.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/user_list_page.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/profile_page.dart';
import 'package:messaging_app/service/firebase_auth/authentication_service.dart';

//homepage
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //list of botton navigation pages
  List<Widget> pages = [
    const UserListPage(),
    const ProfilePage(),
    const ThemePage(),
    const MessageHttp(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("M E S S A G I N G   A P P"),
        actions: [
          IconButton(
            onPressed: () {
              AuthenticationService().logoutUser().whenComplete(
                    () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                  );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: pages[currentIndex],
      drawer: const CustomNavigationDrawer(),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}
