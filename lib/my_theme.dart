import 'package:flutter/material.dart';

class MyTheme {
  static final Color colorRed = Color.fromRGBO(226, 0, 48, 1);
  static final Color colorBlack = Color.fromRGBO(22, 22, 22, 1);
  static final Color colorDarkBlue = Color(0xFF141A2E);
  static final Color colorGrey = Color.fromRGBO(238, 238, 238,1);
  static final Color colorOpacity = Colors.white.withOpacity(.7);
  static final Color colorOpacityBlack = Colors.black.withOpacity(.7);

  static final ThemeData lightTheme = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: colorRed,
    canvasColor: Colors.white,
    cardColor: colorGrey,
    cursorColor: colorOpacity,
    errorColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
    scaffoldBackgroundColor: Colors.white,
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 18, color: Colors.black),
      bodyText2: TextStyle( color: Colors.black),
      headline4: TextStyle(fontSize: 28, color: Colors.black),
      headline5: TextStyle(fontSize: 24, color: Colors.black),
      headline6: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(
        color: colorRed,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.black,
      ),
      selectedLabelStyle: TextStyle(
        color: colorRed,
      ),
      selectedItemColor: colorRed,
      unselectedItemColor: Colors.black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colorDarkBlue,
    ),
    backgroundColor: colorDarkBlue,
    primaryColor: colorRed,
   cardColor: colorBlack,
    canvasColor: Colors.black,
    cursorColor: colorOpacityBlack,
    errorColor: Colors.white,
   scaffoldBackgroundColor: Colors.transparent,
inputDecorationTheme: InputDecorationTheme(
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.grey
      ),
  ),
  hintStyle: TextStyle(color: Colors.white)
),
    iconTheme: IconThemeData(color: Colors.black),

    textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 18, color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      headline4: TextStyle(fontSize: 28, color: Colors.white),
      headline5: TextStyle(fontSize: 24, color: Colors.white),
      headline6: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colorDarkBlue,
      selectedIconTheme: IconThemeData(
        color: colorRed,
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.white,
      ),
      selectedLabelStyle: TextStyle(
        color: Colors.black,
      ),
      selectedItemColor: colorRed,
      unselectedItemColor: Colors.white,
    ),
  );
}
