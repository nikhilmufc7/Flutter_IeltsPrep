import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF21BFBD),
    primaryColor: Color(0xFF21BFBD),
    fontFamily: 'Montserrat',
    primarySwatch: Colors.teal,
    brightness: Brightness.light
    // appBarTheme: AppBarTheme(
    //     elevation: 0.0,
    //     color: Color(0xFF21BFBD),
    //     iconTheme: IconThemeData(color: Colors.white)
    //     ),
    );

final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.black,
    fontFamily: 'Montserrat',
    brightness: Brightness.dark);
