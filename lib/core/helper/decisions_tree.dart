import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mfb/home/home_layout.dart';

import '../../login/login_screen.dart';

class DecisionsTree extends StatelessWidget {
  static const String routeName = 'desision';
  const DecisionsTree({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeLayout();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
