import 'package:flutter/material.dart';
import 'package:mfb/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'on_boarding_screen.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  runApp(MyApp(
    showHome: showHome,
  ));
}

class MyApp extends StatelessWidget {
  final bool showHome;

  const MyApp({Key? key, required this.showHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        OnBoardingScreen.routeName: (_) => OnBoardingScreen(),
      },
      home: showHome ? HomeScreen() : OnBoardingScreen(),
    );
  }
}
