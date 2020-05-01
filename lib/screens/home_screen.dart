import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ielts/app_constants.dart';

import 'package:ielts/services/auth.dart';

import 'package:ielts/widgets/menu_page.dart';

final Color backgroundColor = Color(0xFF21BFBD);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
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
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(top: 48),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
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
                        padding: const EdgeInsets.only(right: 8, top: 14),
                        child: PopupMenuButton<String>(
                          onSelected: (String result) {
                            switch (result) {
                              case 'signOut':
                                signOutGoogle(context);
                                break;

                              default:
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'signOut',
                              child: Text('Sign Out'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text('IELTS',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0)),
                        SizedBox(width: 10.0),
                        Text('Quest',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 25.0))
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).secondaryHeaderColor,
                            blurRadius: 10)
                      ],
                      color: Theme.of(context).canvasColor,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(75.0)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 45.0, left: 25, right: 25),
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
                                        height: 180,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/reading.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(15, 15, 0, 0),
                                          child: Text(
                                            "Reading",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold),
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
                                        height: 180,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/writing.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(15, 15, 0, 0),
                                          child: Text(
                                            "Writing",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold),
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
                                        height: 180,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/listening.jpeg"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(15, 15, 0, 0),
                                          child: Align(
                                            alignment:
                                                FractionalOffset.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15.0),
                                              child: Text(
                                                "Listening",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(RoutePaths.listening);
                                      },
                                    ),
                                    CupertinoButton(
                                      child: Container(
                                        height: 180,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/speaking.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(15, 15, 0, 0),
                                          child: Align(
                                            alignment:
                                                FractionalOffset.bottomLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15.0),
                                              child: Text(
                                                "Speaking",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontFamily: 'Montserrat',
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
        ),
      ),
    );
  }
}
