import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF21BFBD),
    primaryColor: Colors.black,
    fontFamily: 'Montserrat',
    appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: Color(0xFF21BFBD),
        iconTheme: IconThemeData(color: Colors.white)),
  );
}
