import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin{

  AnimationController({
  double value,
  duration,
debugLabel,
  lowerBound: 0.0,
 upperBound: 1.0,
  @required TickerProvider vsync,
})

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: 320.0,
            height: 60.0,
            alignment: FractionalOffset.center,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(247, 64, 106, 1.0),
              borderRadius: BorderRadius.all(const Radius.circular(30.0)),
            ),
            child: Text(
              "Sign In",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
