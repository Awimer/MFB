import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'activity/activity_screen.dart';

class Tagrobaa extends StatelessWidget {
  static const String routeName= 'tagrobaa';
  ActivityScreen? activityScreen;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        activityScreen?.selectedButton==1
      ? Text('1')
            : Text('2')
    ],
    );
  }
}
