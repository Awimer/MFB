import 'package:flutter/material.dart';
import 'package:mfb/home_screen.dart';
import 'package:mfb/login_screen.dart';
import 'package:mfb/register_screen.dart';

import 'activity_screen.dart';
import 'on_boarding_screen.dart';

void main()  {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        OnBoardingScreen.routeName: (_) => OnBoardingScreen(),
        AciviyScreen.routeName: (_) => AciviyScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        Regester.routeName: (_) => Regester(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
