import 'package:flutter/material.dart';

class ThemeUtils {
  static ThemeData themeData = ThemeData(
    fontFamily: 'NeusaNextStd',
    textTheme: const TextTheme(
        headlineLarge: TextStyle(
            color: Color(0xff515C6F),
            fontSize: 30,
            fontWeight: FontWeight.w600),
        displayLarge: TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500),
        displayMedium: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
    useMaterial3: true,
  );
}

class Theme {}
