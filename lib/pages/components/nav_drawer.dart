import 'package:flutter/material.dart';
import 'package:messaging_app/pages/MessageHTTP/message_http.dart';
import 'package:messaging_app/pages/homepage/homepage.dart';
import 'package:messaging_app/pages/login/loginpage.dart';
import 'package:messaging_app/service/firebase_auth/authentication_service.dart';

//custom navigation drawer
class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    //show About dialog
    void showDailog() => showAboutDialog(
          context: context,
          applicationName: "Firebase Messaging",
          applicationIcon: const Icon(
            Icons.message,
            size: 64,
          ),
          applicationVersion: '1.0',
        );
    void goToMessageHTTP() => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MessageHttp(),
          ),
        );

    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Icon(
              Icons.message,
              size: 64,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Homepage(),
                        ),
                      );
                    },
                    leading: const Icon(Icons.home),
                    title: const Text('H O M E'),
                  ),
                  ListTile(
                    onTap: () => goToMessageHTTP(),
                    leading: const Icon(Icons.messenger),
                    title: const Text('M E S S A G E  H T T P'),
                  ),
                  ListTile(
                    onTap: showDailog,
                    leading: const Icon(Icons.info_rounded),
                    title: const Text('A B O U T'),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: ListTile(
              onTap: () {
                AuthenticationService().logoutUser().whenComplete(
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      ),
                    );
              },
              leading: const Icon(Icons.logout),
              title: const Text('L O G O U T'),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
