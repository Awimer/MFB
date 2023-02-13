import 'package:flutter/material.dart';
import 'package:mfb/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.routeName : (_) => HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
