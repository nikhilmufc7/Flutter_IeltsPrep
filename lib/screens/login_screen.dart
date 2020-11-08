import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:ielts/utils/app_constants.dart';

import 'package:ielts/services/auth.dart';

import 'package:ielts/widgets/bezierContainer.dart';

enum AuthMode { Signup, Login }

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController firstNameInputController;
  TextEditingController emailInputController;
  TextEditingController passwordInputController;

  AuthMode _authMode = AuthMode.Signup;

  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    firstNameInputController = TextEditingController();

    emailInputController = TextEditingController();
    passwordInputController = TextEditingController();
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 300,
        ));

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
//    _animationHeight.addListener(()=>
//    setState((){}));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid, Check for spaces or special characters';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'Password must be longer than 6 characters';
    } else {
      return null;
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      if (_authMode == AuthMode.Login) {
        await signIn(emailInputController.text, passwordInputController.text);
        print('successful');

        Navigator.pushReplacementNamed(context, RoutePaths.home);
      } else {
        await signUp(emailInputController.text, passwordInputController.text,
            firstNameInputController.text);

        Navigator.pushReplacementNamed(context, RoutePaths.home);
      }
      //   } on AuthException catch (error) {
      //     print('''
      //   caught firebase auth exception\n
      //   ${error.code}\n
      //   ${error.message}
      // ''');
      //     _showErrorDialog(
      //         'Could not authenticate you.$errorMessage Please try again later.');
    } catch (error) {
      var errorM =
          'Could not authenticate you.$errorMessage Please try again later.';

      _showErrorDialog(errorM);

      print(error);
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  Widget _firstNameEntryField(String title) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(15)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          TextFormField(
              style:
                  TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              controller: firstNameInputController,
              validator: (value) {
                if (value.length < 3) {
                  return "Please enter a valid first name";
                }
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _emailEntryField(String title) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(15)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          TextFormField(
              style:
                  TextStyle(color: Colors.black, fontStyle: FontStyle.italic),
              controller: emailInputController,
              keyboardType: TextInputType.emailAddress,
              validator: emailValidator,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _passwordEntryField(String title) {
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      curve: Curves.easeIn,
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(15)),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: passwordInputController,
              obscureText: true,
              validator: pwdValidator,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  labelStyle: TextStyle(color: Colors.black),
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return FlatButton(
      onPressed: _submit,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(15)),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            color: Color(0xFF21BFBD)),
        child: Text(
          '${_authMode == AuthMode.Login ? 'Login' : 'Register'}',
          style:
              TextStyle(fontSize: ScreenUtil().setSp(20), color: Colors.white),
        ),
      ),
    );
  }

  Widget _googleButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        try {
          await signInWithGoogle();
          FirebaseUser _user = await FirebaseAuth.instance.currentUser();
          if (_user != null) {
            Navigator.pushReplacementNamed(context, RoutePaths.home);
          } else {
            setState(() {});
          }
        } catch (error) {
          switch (error.code) {
            case "sign_in_canceled":
              errorMessage = "Sign in cancelled";
              break;
          }
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            0, ScreenUtil().setHeight(10), 0, ScreenUtil().setHeight(10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage("assets/googlelogo.jpg"),
                height: ScreenUtil().setHeight(35)),
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _anonymousLoginButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        try {
          await anonymousSignIn();

          Navigator.pushReplacementNamed(context, RoutePaths.home);
        } catch (error) {
          print(error);
        }
      },
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      // borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            0, ScreenUtil().setHeight(10), 0, ScreenUtil().setHeight(10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.screen_lock_portrait,
              color: Colors.black,
            ),
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
              child: Text(
                'Skip Login',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(20),
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: ScreenUtil().setWidth(20),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(10)),
              child: Divider(
                color: Colors.black,
                thickness: 1,
              ),
            ),
          ),
          Text(
            'or',
            style: TextStyle(color: Colors.black),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(10)),
              child: Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(20),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${_authMode == AuthMode.Login ? 'Don\'t have an account ?' : 'Already have a account ?'}',
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(13),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          InkWell(
            onTap: () {
              _switchAuthMode();
            },
            child: Text(
              '${_authMode == AuthMode.Login ? 'Register' : 'Login'}',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: ScreenUtil().setSp(13),
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Iel',
          style: GoogleFonts.portLligatSans(
            fontSize: ScreenUtil().setSp(30),
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ts',
              style: TextStyle(
                  color: Colors.black, fontSize: ScreenUtil().setSp(30)),
            ),
            TextSpan(
              text: ' Va',
              style: TextStyle(
                  color: Color(0xffe46b10), fontSize: ScreenUtil().setSp(30)),
            ),
            TextSpan(
              text: 'ult',
              style: TextStyle(
                  color: Colors.black, fontSize: ScreenUtil().setSp(30)),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          if (_authMode == AuthMode.Signup) _firstNameEntryField('First Name'),
          _emailEntryField('Email'),
          _passwordEntryField('Password'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);

    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return null;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: SizedBox(),
                      ),
                      _title(),
                      SizedBox(
                        height: ScreenUtil().setHeight(50),
                      ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      _submitButton(),
                      Visibility(
                        visible: _authMode == AuthMode.Login,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RoutePaths.resetpassword);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(10)),
                            alignment: Alignment.centerRight,
                            child: Text('Forgot Password ?',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(14),
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      _divider(),
                      _googleButton(),
                      SizedBox(
                        height: ScreenUtil().setHeight(20),
                      ),
                      _anonymousLoginButton(),
                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _createAccountLabel(),
                ),
                Positioned(
                    top: -MediaQuery.of(context).size.height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: BezierContainer())
              ],
            ),
          ))),
    );
  }
}
