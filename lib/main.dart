import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home/home_layout.dart';
import 'package:mfb/home/home_screen.dart';
import 'package:mfb/home/settings/settings.dart';
import 'package:mfb/register_login/login_screen.dart';
import 'package:mfb/register_login/register_screen.dart';

import 'forget_password/create_new_password.dart';
import 'forget_password/forget_password.dart';
import 'forget_password/verification_code.dart';
import 'home/favorite.dart';
import 'register_login/activity_screen.dart';
import 'on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        OnBoardingScreen.routeName: (_) => OnBoardingScreen(),
        AciviyScreen.routeName: (_) => AciviyScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        Regester.routeName: (_) => Regester(),
        ForgetScreen.routeName: (_) => ForgetScreen(),
        VerifictionCode.routeName: (_) => VerifictionCode(),
        CreatePassword.routeName: (_) => CreatePassword(),
        HomeLayout.routeName: (_) => HomeLayout(),
      },
      initialRoute: HomeLayout.routeName,
    );
  }
}
