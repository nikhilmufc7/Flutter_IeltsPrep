import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/utils/app_constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class QuizResultScreen extends StatefulWidget {
  final int quizScore;
  final List questions;
  final List answers;
  QuizResultScreen({Key key, this.quizScore, this.questions, this.answers})
      : super(key: key);

  @override
  _QuizResultScreenState createState() =>
      _QuizResultScreenState(quizScore, questions, answers);
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  final int quizScore;
  final List questions;
  final List answers;
  _QuizResultScreenState(this.quizScore, this.questions, this.answers);

  bool showAnswers = false;

  String resultText;

  double scoreInDouble = 0.0;

  void _resultText() {
    if (quizScore >= 8) {
      resultText = 'Keep on learning!';
    } else if (quizScore >= 6) {
      resultText = 'You can do better!';
    } else if (quizScore <= 5) {
      resultText = 'Review the answers for better understanding';
    }
  }

  void scoreConverter() {
    if (quizScore == 1) {
      scoreInDouble = 0.1;
    } else if (quizScore == 2) {
      scoreInDouble = 0.2;
    } else if (quizScore == 3) {
      scoreInDouble = 0.3;
    } else if (quizScore == 4) {
      scoreInDouble = 0.4;
    } else if (quizScore == 5) {
      scoreInDouble = 0.5;
    } else if (quizScore == 6) {
      scoreInDouble = 0.6;
    } else if (quizScore == 7) {
      scoreInDouble = 0.7;
    } else if (quizScore == 8) {
      scoreInDouble = 0.8;
    } else if (quizScore == 9) {
      scoreInDouble = 0.9;
    } else if (quizScore == 10) {
      scoreInDouble = 1.0;
    }
  }

  @override
  void initState() {
    scoreConverter();
    _resultText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.popAndPushNamed(context, RoutePaths.quiz),
        isExtended: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Icon(Icons.fast_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(0, 65, 106, 1),
              Color.fromRGBO(228, 229, 230, 1)
            ])),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: showAnswers
                  ? EdgeInsets.only(top: ScreenUtil().setHeight(30))
                  : EdgeInsets.only(top: ScreenUtil().setHeight(80)),
              child: Center(
                child: CircularPercentIndicator(
                  radius: ScreenUtil().setWidth(160),
                  lineWidth: ScreenUtil().setWidth(16),
                  animation: true,
                  percent: scoreInDouble,
                  center: Text(
                    quizScore.toString() + "/10",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(24)),
                  ),
                  footer: Text(
                    "Your Score",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(24),
                        fontFamily: 'Montserrat'),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purple,
                ),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(40)),
            Column(
              children: <Widget>[
                Visibility(
                  visible: showAnswers == false,
                  child: Container(
                    height: ScreenUtil().setHeight(150),
                    width: ScreenUtil().setWidth(300),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (quizScore < 6)
                            ? AssetImage("assets/pushing.png")
                            : AssetImage("assets/sucess.png"),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Center(
                    child: RichText(
                  text: TextSpan(
                    text: (quizScore > 5) ? "Well Done!" : "Keep Pushing!",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: Colors.tealAccent,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                )),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Center(
                    child: RichText(
                  text: TextSpan(
                    text: resultText,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                )),
              ],
            ),
            SizedBox(height: ScreenUtil().setHeight(30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Review Answers',
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    )),
                Switch(
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.white,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.blue,
                  value: showAnswers,
                  onChanged: (value) {
                    setState(() {
                      showAnswers = value;
                    });
                  },
                ),
              ],
            ),
            Visibility(
              visible: showAnswers,
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setHeight(14)),
                child: Text(
                  'Answers Review',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Visibility(
              visible: showAnswers,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(20)),
                      child: Card(
                        color: Color.fromRGBO(57, 106, 137, 0.6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 2,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(20),
                              vertical: ScreenUtil().setHeight(10)),
                          leading: Container(
                            padding: EdgeInsets.only(
                                right: ScreenUtil().setWidth(12)),
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.0, color: Colors.white24))),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(16)),
                            ),
                          ),
                          title: Text(
                            questions[index],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(16),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400),
                          ),
                          subtitle: Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(20)),
                              child: Text('Answer: ' + answers[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(14),
                                      color: Colors.white))),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
