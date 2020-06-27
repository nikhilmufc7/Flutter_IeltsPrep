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
  bottomAppBarColor: Colors.white,
  splashColor: Colors.white,
  indicatorColor: Color(0xFF21BFBD), // for appbar in forums and chats
);

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.black,
  secondaryHeaderColor: Colors.white,
  canvasColor: Colors.black,
  fontFamily: 'Montserrat',
  backgroundColor: Color.fromRGBO(0, 0, 0, .93),
  accentColor: Colors.white,
  brightness: Brightness.dark,
  bottomAppBarColor: Colors.black,
  splashColor: Color.fromRGBO(37, 42, 65, 1),
  indicatorColor: Color.fromRGBO(18, 22, 33, 1),
);
