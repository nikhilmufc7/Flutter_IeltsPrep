import 'dart:ui' as ui;
import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:ielts/screens/home_screen.dart';
import 'package:ielts/services/admob_service.dart';
import 'package:ielts/utils/app_constants.dart';

import 'package:ielts/models/quiz.dart';
import 'package:ielts/screens/quiz_detail_screen.dart';
import 'package:ielts/viewModels/quizCrudModel.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final double _borderRadius = 24;
  final ams = AdMobService();

  int _currentIndex = 0;
  int _scoresIndex = 0;

  List quizzes;

  bool completed = false;

  List<String> checkedItems = [];

  var items = [
    GradientColors(
      Color(0xff6DC8F3),
      Color(0xff73A1F9),
    ),
    GradientColors(
      Color(0xffFFB157),
      Color(0xffFFA057),
    ),
    GradientColors(
      Color(0xffFF5B95),
      Color(0xffF8556D),
    ),
    GradientColors(
      Color(0xffD76EF5),
      Color(0xff8F7AFE),
    ),
    GradientColors(
      Color(0xff42E695),
      Color(0xff3BB2B8),
    ),
  ];

  LinearGradient _color() {
    return LinearGradient(colors: [
      items[_currentIndex].startColor,
      items[_currentIndex].endColor
    ]);
  }

  BoxShadow _boxShadowColor() {
    return BoxShadow(
      color: items[_currentIndex].endColor,
      blurRadius: 12,
      offset: Offset(0, 6),
    );
  }

  void _changeToZero() {
    if (_currentIndex > 3) {
      _currentIndex = 0;
    }
  }

  void _getCheckedItems() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('checkedItems')) {
      checkedItems = prefs.getStringList('checkedItems');
    } else {
      prefs.setStringList('checkedItems', checkedItems);
    }
  }

  @override
  void initState() {
    _getCheckedItems();

    super.initState();
    Admob.initialize(ams.getAdMobAppId());
  }

  Quiz quiz;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    final productProvider = Provider.of<QuizCrudModel>(context);

    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).splashColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).indicatorColor,
          title: Text(
            'Quizzes',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          elevation: 0,
          actions: <Widget>[],
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, RoutePaths.home);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          )),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ArcClipper(),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).indicatorColor,
              ),
              height: ScreenUtil().setHeight(200),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(40),
                left: ScreenUtil().setWidth(10),
                right: ScreenUtil().setWidth(10)),
            child: StreamBuilder<QuerySnapshot>(
                stream: productProvider.fetchQuizAsStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    quizzes = snapshot.data.documents
                        .map((doc) => Quiz.fromMap(doc.data, doc.documentID))
                        .toList();

                    return ListView.builder(
                      physics: ClampingScrollPhysics(),
                      itemCount: quizzes.length,
                      itemBuilder: (context, index) {
                        _scoresIndex = _scoresIndex + 1;
                        _changeToZero();
                        _getCheckedItems();

                        _currentIndex = _currentIndex + 1;
                        return _inkwell(quizzes[index]);
                      },
                    );
                  } else {
                    return Container(
                        height: screenHeight,
                        child: Center(child: CircularProgressIndicator()));
                  }
                }),
          ),
          Visibility(
            visible: premium_user != true,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AdmobBanner(
                  adUnitId: ams.getBannerAdId(),
                  adSize: AdmobBannerSize.FULL_BANNER),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inkwell(Quiz quiz) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuizDetailScreen(quiz: quiz)));
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
          child: Stack(
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_borderRadius),
                  gradient: _color(),
                  boxShadow: [
                    _boxShadowColor(),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: CustomPaint(
                  size: Size(
                      ScreenUtil().setHeight(100), ScreenUtil().setHeight(150)),
                  painter: CustomCardShapePainter(
                      _borderRadius,
                      items[_currentIndex].startColor,
                      items[_currentIndex].endColor),
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        'assets/quiz.png',
                        height: ScreenUtil().setHeight(64),
                        width: ScreenUtil().setWidth(64),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FittedBox(
                            child: Text(
                              quiz.quizTitle,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: ScreenUtil().setSp(20),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(15)),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.cached,
                                color: Colors.white,
                                size: ScreenUtil().setHeight(16),
                              ),
                              SizedBox(
                                width: ScreenUtil().setHeight(8),
                              ),
                              FittedBox(
                                child: Text(
                                  'Total Questions : ${quiz.question.length}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: ScreenUtil().setSp(15)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: FittedBox(
                        child: CheckboxGroup(
                            checked: checkedItems,
                            checkColor: Colors.white,
                            activeColor: Colors.black,
                            labels: [quiz.id],
                            labelStyle: TextStyle(fontSize: 0),
                            onSelected: (List<String> checked) {
                              print("${checked.toString()}");
                            },
                            onChange: (bool isChecked, String label,
                                int index) async {
                              print(label);
                              final prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool(label, isChecked);
                              print(prefs.getBool(label) ?? 0);

                              setState(() {
                                isChecked = prefs.getBool(label);
                                completed = prefs.getBool(label);
                                if (checkedItems.contains(label)) {
                                  checkedItems.remove(label);
                                } else {
                                  checkedItems.add(label);
                                }
                                prefs.setStringList(
                                    'checkedItems', checkedItems);
                                print(checkedItems);
                              });
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientColors {
  final Color startColor;
  final Color endColor;

  GradientColors(
    this.startColor,
    this.endColor,
  );
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = ScreenUtil().setWidth(12);

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
