import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFF21BFBD),
  primaryColor: Color(0xFF21BFBD),
  fontFamily: 'Montserrat',
  primarySwatch: Colors.teal,
  brightness: Brightness.light,
  canvasColor: Colors.white, // color for content background
  secondaryHeaderColor: Colors.teal, // boxshadow color
  backgroundColor: Color(0xff454dff), // side bar color
  accentColor: Colors.black, // font color
);

final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.black,
    secondaryHeaderColor: Colors.white,
    canvasColor: Colors.black,
    fontFamily: 'Montserrat',
    backgroundColor: Color.fromRGBO(0, 0, 0, .93),
    accentColor: Colors.white,
    brightness: Brightness.dark);
