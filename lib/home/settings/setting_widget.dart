import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  Color pinkColor ;
  Icon changePrefixIcon  ;
  String title  ;
  Icon changeSuffixIcon ;
  SettingsWidget({
    required this.pinkColor,
    required this.changeSuffixIcon,
    required this.title,
    required this.changePrefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: pinkColor,
          ),
          width: 36,
          height: 36,
          child: changePrefixIcon,
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Text(title,
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        changeSuffixIcon
      ],
    );
  }

}