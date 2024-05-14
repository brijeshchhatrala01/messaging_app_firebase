import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/firebase_options.dart';
import 'package:messaging_app/pages/splash/splash.dart';
import 'package:messaging_app/pages/homepage/bottom_navigation_pages/theme_page.dart';
import 'package:messaging_app/theme/dark_theme.dart';
import 'package:messaging_app/theme/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

//main method
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize app with firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  //intialize shared preference
  late SharedPreferences userColor;


  void initial() async {
    userColor = await SharedPreferences.getInstance();
    setState(() {
      //set color   
      screenPickerColor = Color(userColor.getInt('color') ?? 4280391411 );
      //print("Color : ${userColor.getInt('color').toString()}");
    });
  }

  @override
  void initState() {
    initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkMode,
      home: const SplashScreen(),
    );
  }
}
