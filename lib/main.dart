import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mfb/category_screen.dart';
import 'package:mfb/home/chat/chat_room.dart';
import 'package:mfb/home/home_layout.dart';
import 'package:mfb/activity/activity_screen.dart';
import 'package:mfb/home/profile/post_media.dart';
import 'package:mfb/home/profile/profile_modify.dart';
import 'package:mfb/login/login_screen.dart';
import 'package:mfb/player%20details/player_details.dart';
import 'package:mfb/player%20details/rate_player.dart';
import 'package:mfb/register/register_screen.dart';
import 'package:mfb/home/settings/setting_provider.dart';
import 'package:mfb/tagroba.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';
import 'forget_password/create_new_password.dart';
import 'forget_password/forget_password.dart';
import 'forget_password/verification_code.dart';
import 'home/real_page.dart';
import 'my_theme/my_theme.dart';
import 'on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider<SettingsProvider>(
      create: (buildContext) {
        return SettingsProvider();
      },
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  late SettingsProvider settingsProvider;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);

    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        themeMode: settingsProvider.currentTheme,
        debugShowCheckedModeBanner: false,
        routes: {
          OnBoardingScreen.routeName: (_) => OnBoardingScreen(),
          ActivityScreen.routeName: (_) => const ActivityScreen(),
          LoginScreen.routeName: (_) => const LoginScreen(),
          Register.routeName: (_) => const Register(),
          ForgetScreen.routeName: (_) => ForgetScreen(),
          VerifictionCode.routeName: (_) => VerifictionCode(),
          CreatePassword.routeName: (_) => CreatePassword(),
          HomeLayout.routeName: (_) => HomeLayout(),
          Tagroba.routeName: (_) => Tagroba(),
          PlayerDetails.routeName: (_) => const PlayerDetails(),
          ProfileModify.routeName: (_) => const ProfileModify(),
          ChatRoom.routeName: (_) => const ChatRoom(),
          PostMedia.routeName: (_) => const PostMedia(),
          CategoryScreen.routeName: (_) => const CategoryScreen(),
          RealPage.routeName: (_) => const RealPage(),
          RatePlayer.routeName: (_) => const RatePlayer(),
          //DecisionsTree.routeName: (_) => const DecisionsTree()
        },
        initialRoute: FirebaseAuth.instance.currentUser != null
            ? HomeLayout.routeName
            : LoginScreen.routeName,
      );
    });
  }
}
