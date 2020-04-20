import 'package:flutter/material.dart';
import 'package:ielts/app_constants.dart';
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
      resultText = 'Well Done! Keep learning';
    } else if (quizScore >= 6) {
      resultText = 'Not bad, Keep practicing';
    } else if (quizScore <= 5) {
      resultText =
          'Keep practicing! \n Review the answers for better understanding';
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
                  ? const EdgeInsets.only(top: 30.0)
                  : const EdgeInsets.only(top: 80.0),
              child: Center(
                child: CircularPercentIndicator(
                  radius: 160.0,
                  lineWidth: 16.0,
                  animation: true,
                  percent: scoreInDouble,
                  center: Text(
                    quizScore.toString() + "/10",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0),
                  ),
                  footer: Text(
                    "Your Score",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                        fontFamily: 'Montserrat'),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.purple,
                ),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: Text(
                resultText ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Review Answers',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                    )),
                Switch(
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.green,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
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
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  'Answers Review',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
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
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 20, right: 20),
                      child: Card(
                        color: Color.fromRGBO(57, 106, 137, 0.6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 2,
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Text(
                                "${index + 1}",
                              )),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              questions[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Answer: " + answers[index],
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
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
