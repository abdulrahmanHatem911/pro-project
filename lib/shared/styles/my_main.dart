

import 'package:flutter/material.dart';

class MyMainColors {
  static const MaterialColor myBlue = Colors.blue;
  static const Color myGrey = Colors.grey;
  static const Color myWhite = Colors.white;
  static const Color myBlack = Colors.black;
  static const Color myRed = Colors.red;
  static const Color myOuterSpace = Color(0xff333739);
}

class MyTextTheme {
  static TextTheme textTheme() {

    return TextTheme(
      bodyLarge: TextStyle(fontSize: 18),
      titleMedium: TextStyle(height: 1.3, fontSize: 14.0),
    );
  }
}
