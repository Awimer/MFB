import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home/home_layout.dart';
import 'package:mfb/activity/activity_screen.dart';
import 'package:mfb/login/login_screen.dart';
import 'package:mfb/register/register_screen.dart';
import 'package:mfb/home/settings/setting_provider.dart';
import 'package:mfb/tagroba.dart';
import 'package:mfb/tagrobaa.dart';
import 'package:provider/provider.dart';

import 'forget_password/create_new_password.dart';
import 'forget_password/forget_password.dart';
import 'forget_password/verification_code.dart';
import 'my_theme/my_theme.dart';
import 'on_boarding/on_boarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<SettingsProvider>(
      create: (buildContext) {
        return SettingsProvider();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {

  late SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: settingsProvider.currentTheme,

      debugShowCheckedModeBanner: false,
      routes: {
        OnBoardingScreen.routeName: (_) => OnBoardingScreen(),
        ActivityScreen.routeName: (_) => ActivityScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        Register.routeName: (_) => Register(),
        ForgetScreen.routeName: (_) => ForgetScreen(),
        VerifictionCode.routeName: (_) => VerifictionCode(),
        CreatePassword.routeName: (_) => CreatePassword(),
        HomeLayout.routeName: (_) => HomeLayout(),
        Tagroba.routeName: (_) => Tagroba(),
      },
      initialRoute: Tagroba.routeName,
    );
  }
}
