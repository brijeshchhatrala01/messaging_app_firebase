// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/service/firebase_auth/authentication_check.dart';

//splash screen page
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //check internet connection
    checkInternetConnectivity();
    super.initState();
  }

  //navigate to login page
  navigateToLogin() {
    Timer timer = Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthCheck(),
          ));
    });
  }

  //show alert dailogue about offline
  Future<void> showNetworkError() async {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Network Not Available'),
          content: Image.asset(
            'assets/smartphone.png',
            width: width * 0.4,
            height: height * 0.3,
          ),
          actions: [
            ElevatedButton(
                onPressed: () => exit(0), child: const Text('E X I T'),),
          ],
        );
      },
    );
  }

  //check internet connection
  void checkInternetConnectivity() async {
    var connection = await Connectivity().checkConnectivity();

    if (connection == ConnectivityResult.mobile ||
        connection == ConnectivityResult.wifi) {
      navigateToLogin();
    } else {
      showNetworkError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.message,
          size: 90,
        ),
        SizedBox(
          height: 18,
        ),
        Center(
          child: Text(
            "F I R E B A S E   M E S S A G I N G",
            style: TextStyle(
                fontSize: 20, letterSpacing: 1, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }
}
