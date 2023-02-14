import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MFB'),
        /*actions: [
          IconButton(
              onPressed: () async {
                // navigate directly to onboarding screen
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('showHome', false);

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => OnBoardingScreen()));
              },
              icon: Icon(Icons.logout)),
        ],
      */),
    );
  }
}
