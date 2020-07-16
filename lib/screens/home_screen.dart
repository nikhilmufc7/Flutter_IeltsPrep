import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ielts/services/admob_service.dart';
import 'package:ielts/utils/app_constants.dart';

import 'package:ielts/widgets/menu_page.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

final Color backgroundColor = Color(0xFF21BFBD);
bool premium_user = false;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  //       var appcastURL = 'https://www.mydomain.com/myappcast.xml';
  // final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  final ams = AdMobService();

  @override
  void initState() {
    getPremium();
    super.initState();
    Admob.initialize(ams.getAdMobAppId());

    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  void getPremium() async {
    final user = await FirebaseAuth.instance.currentUser();

    try {
      DocumentSnapshot snap = await Firestore.instance
          .collection('premium_users')
          .document(user.uid)
          .get();

      setState(() {
        if (snap.exists) {
          setState(() {
            premium_user = true;
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: <Widget>[
            MenuPage(),
            dashboard(context),
            // curvedContainer(context),
          ],
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: (isCollapsed)
              ? BorderRadius.circular(0)
              : BorderRadius.circular(40),
          shadowColor: Colors.white,
          elevation: 8,
          color: Theme.of(context).primaryColor,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(48)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(18)),
                            child: InkWell(
                              child: Icon(Icons.menu, color: Colors.white),
                              onTap: () {
                                setState(() {
                                  if (isCollapsed)
                                    _controller.forward();
                                  else
                                    _controller.reverse();

                                  isCollapsed = !isCollapsed;
                                });
                              },
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(8),
                                  top: ScreenUtil().setHeight(14)),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RoutePaths.settings);
                                  })),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(25)),
                      Padding(
                        padding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                        child: Row(
                          children: <Widget>[
                            Text('IELTS',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(25))),
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            Text('Vault',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(25)))
                          ],
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(40)),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).secondaryHeaderColor,
                                blurRadius: 10)
                          ],
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(ScreenUtil().setWidth(75))),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(45),
                              left: ScreenUtil().setWidth(25),
                              right: ScreenUtil().setWidth(25)),
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                //on swiping left
                                if (details.delta.dx < 6) {
                                  if (isCollapsed) {
                                    return null;
                                  } else {
                                    setState(() {
                                      _controller.reverse();
                                      isCollapsed = true;
                                    });
                                  }
                                }
                                // }
                              },
                              onTap: (isCollapsed)
                                  ? null
                                  : () {
                                      setState(() {
                                        _controller.reverse();
                                        isCollapsed = true;
                                      });
                                    },
                              child: ListView(
                                physics: ClampingScrollPhysics(),
                                children: <Widget>[
                                  FittedBox(
                                    fit: BoxFit.cover,
                                    child: Row(
                                      children: <Widget>[
                                        CupertinoButton(
                                          child: Container(
                                            height: screenHeight / 4.0,
                                            width: screenWidth / 2.3,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/reading.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil()
                                                          .setWidth(12)),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  ScreenUtil().setWidth(15),
                                                  ScreenUtil().setWidth(15),
                                                  0,
                                                  0),
                                              child: Text(
                                                premium_user
                                                    ? "Reading"
                                                    : "Not reaidng",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        ScreenUtil().setSp(20),
                                                    fontFamily: 'Montserrat',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed(RoutePaths.reading);
                                          },
                                        ),
                                        CupertinoButton(
                                          child: Container(
                                            height: screenHeight / 4.0,
                                            width: screenWidth / 2.3,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/writing.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil()
                                                          .setWidth(12)),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  ScreenUtil().setWidth(15),
                                                  ScreenUtil().setWidth(15),
                                                  0,
                                                  0),
                                              child: Text(
                                                "Writing",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                        ScreenUtil().setSp(20),
                                                    fontFamily: 'Montserrat',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed(RoutePaths.writing);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  // tj
                                  FittedBox(
                                    fit: BoxFit.cover,
                                    child: Row(
                                      children: <Widget>[
                                        CupertinoButton(
                                          child: Container(
                                            height: screenHeight / 4.0,
                                            width: screenWidth / 2.3,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/listening.jpeg"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil()
                                                          .setWidth(12)),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  ScreenUtil().setWidth(15),
                                                  ScreenUtil().setWidth(15),
                                                  0,
                                                  0),
                                              child: Align(
                                                alignment:
                                                    FractionalOffset.bottomLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: ScreenUtil()
                                                          .setWidth(15)),
                                                  child: Text(
                                                    "Listening",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: ScreenUtil()
                                                            .setSp(20),
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                RoutePaths.listening);
                                          },
                                        ),
                                        CupertinoButton(
                                          child: Container(
                                            height: screenHeight / 4.0,
                                            width: screenWidth / 2.3,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/speaking.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenUtil()
                                                          .setWidth(12)),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  ScreenUtil().setWidth(15),
                                                  ScreenUtil().setHeight(15),
                                                  0,
                                                  0),
                                              child: Align(
                                                alignment:
                                                    FractionalOffset.bottomLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: ScreenUtil()
                                                          .setWidth(15)),
                                                  child: Text(
                                                    "Speaking",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: ScreenUtil()
                                                            .setSp(20),
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed(RoutePaths.speaking);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: premium_user != true,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AdmobBanner(
                      adUnitId: ams.getBannerAdId(),
                      adSize: AdmobBannerSize.FULL_BANNER),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
