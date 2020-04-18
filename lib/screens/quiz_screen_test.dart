import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'package:ielts/models/quiz.dart';
import 'package:ielts/screens/quiz_detail_screen.dart';
import 'package:ielts/viewModels/quizCrudModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizScreenTest extends StatefulWidget {
  @override
  _QuizScreenTestState createState() => _QuizScreenTestState();
}

class _QuizScreenTestState extends State<QuizScreenTest> {
  final double _borderRadius = 24;

  int _currentIndex = 0;
  int _scoresIndex = 0;

  List quizzes;

  bool completed = false;

  List<String> checkedItems = [];

  var items = [
    PlaceInfo(Color(0xff6DC8F3), Color(0xff73A1F9), 4.4),
    PlaceInfo(
      Color(0xffFFB157),
      Color(0xffFFA057),
      3.7,
    ),
    PlaceInfo(
      Color(0xffFF5B95),
      Color(0xffF8556D),
      4.5,
    ),
    PlaceInfo(
      Color(0xffD76EF5),
      Color(0xff8F7AFE),
      4.1,
    ),
    PlaceInfo(
      Color(0xff42E695),
      Color(0xff3BB2B8),
      4.2,
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
    checkedItems = prefs.getStringList('checkedItems');
  }

  @override
  void initState() {
    _getCheckedItems();
    super.initState();
  }

  Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<QuizCrudModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Foody'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: productProvider.fetchQuizAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              quizzes = snapshot.data.documents
                  .map((doc) => Quiz.fromMap(doc.data, doc.documentID))
                  .toList();

              return ListView.builder(
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
              return CircularProgressIndicator();
            }
          }),
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
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: <Widget>[
              Container(
                height: 150,
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
                  size: Size(100, 150),
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
                        height: 64,
                        width: 64,
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            quiz.quizTitle,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Avenir',
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'This is category',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Avenir',
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Text(
                                  'items[index].locationa',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Avenir',
                                  ),
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
                            labels: [quiz.id.toString()],
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

class PlaceInfo {
  final double rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(
    this.startColor,
    this.endColor,
    this.rating,
  );
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

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
