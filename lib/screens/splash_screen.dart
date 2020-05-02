import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ielts/utils/app_constants.dart';
import 'package:ielts/screens/home_screen.dart';
import 'package:ielts/services/auth.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
              if (currentUser == null)
                {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutePaths.login,
                  ),
                }
              else
                {
                  userId = currentUser.uid,
                  Firestore.instance
                      .collection("users")
                      .document(currentUser.uid)
                      .get()
                      .then((DocumentSnapshot result) =>
                          Navigator.popAndPushNamed(context, RoutePaths.home))
                      .catchError((err) => print(err))
                }
            })
        .catchError((err) => print(err));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Image.asset('assets/giphy.gif'),
        ),
      ),
    );
  }
}
