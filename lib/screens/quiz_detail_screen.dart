import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/models/quiz.dart';
import 'package:ielts/screens/quiz_result_screen.dart';

class QuizDetailScreen extends StatefulWidget {
  final Quiz quiz;
  QuizDetailScreen({Key key, this.quiz}) : super(key: key);

  @override
  _QuizDetailScreenState createState() => _QuizDetailScreenState(quiz);
}

class _QuizDetailScreenState extends State<QuizDetailScreen> {
  final Quiz quiz;
  _QuizDetailScreenState(this.quiz);

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  bool _isRadioEnabled = true;

  var parser = EmojiParser();

  String _answer;
  String _selectedAnswer;
  int answerScore = 0;
  List<String> quizzesScores = [];

  _onChanged() {
    setState(() {
      _isRadioEnabled = !_isRadioEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;

    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    final Map options = quiz.options["$_currentIndex"];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: Colors.white,
          key: _key,
          appBar: AppBar(
            title: FittedBox(
                child: Text(
              quiz.quizTitle,
              style: TextStyle(color: Colors.white),
            )),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Container(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    height: screenHeight / 4,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
                    child: Column(children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.white70,
                            child: Text(
                              "${_currentIndex + 1}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(16)),
                          Expanded(
                              child: Text(
                            quiz.question[_currentIndex],
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(18),
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(25)),
                      Card(
                        elevation: 8,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(12),
                              horizontal: ScreenUtil().setWidth(12)),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: options.keys.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(8)),
                                  child: Card(
                                    color: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: RadioListTile(
                                        activeColor: (_isRadioEnabled)
                                            ? Colors.deepPurpleAccent
                                            : Colors.deepPurpleAccent,
                                        title: Text(
                                          options["$index"],
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Montserrat',
                                              fontSize: ScreenUtil().setSp(15),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        value: options["$index"],
                                        groupValue: _selectedAnswer,
                                        onChanged: _isRadioEnabled
                                            ? (value) {
                                                setState(() {
                                                  _selectedAnswer = value;
                                                  if (_selectedAnswer ==
                                                      quiz.answers[
                                                          _currentIndex]) {
                                                    answerScore =
                                                        answerScore + 1;
                                                    _onChanged();

                                                    _answer =
                                                        'Answer is right, well done!';

                                                    print(_answer);
                                                    print(answerScore);
                                                  } else {
                                                    _answer =
                                                        'Wrong Answer, try again';
                                                    print(answerScore);
                                                    _onChanged();

                                                    print(_answer);
                                                  }
                                                });
                                              }
                                            : null),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      Column(
                        children: <Widget>[
                          Visibility(
                              visible: _answer != null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setHeight(8)),
                                    child: Text(
                                      (_answer == 'Answer is right, well done!')
                                          ? '${parser.emojify(':wink:')}'
                                          : '${parser.emojify(':disappointed:')} ',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(36)),
                                    ),
                                  ),
                                  Container(
                                      width: ScreenUtil().setWidth(220),
                                      padding: EdgeInsets.all(
                                          ScreenUtil().setHeight(10)),
                                      decoration: BoxDecoration(
                                          color: (_answer ==
                                                  'Answer is right, well done!')
                                              ? Colors.lightGreen
                                              : Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: FittedBox(
                                        child: Text(
                                          _answer ?? '',
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )),
                                ],
                              )),
                          Visibility(
                              visible: _answer == 'Wrong Answer, try again',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setHeight(8)),
                                    child: Text(
                                      parser.emojify(':heart:'),
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(36)),
                                    ),
                                  ),
                                  Container(
                                    width: ScreenUtil().setWidth(220),
                                    padding: EdgeInsets.all(
                                        ScreenUtil().setHeight(10)),
                                    decoration: BoxDecoration(
                                        color: Colors.cyanAccent,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      ' Correct Answer is ${quiz.answers[_currentIndex]} ',
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: ScreenUtil().setSp(16),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          _currentIndex == (quiz.question.length - 1)
                              ? "Submit"
                              : "Next",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(16),
                              fontWeight: FontWeight.w600),
                        ),
                        color: Colors.deepPurpleAccent,
                        onPressed: _nextSubmit,
                      )
                    ])),
              ],
            ),
          )),
    );
  }

  Future<bool> _onWillPop() async {
    return showDialog<bool>(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
                "Are you sure you want to quit the quiz? All your progress will be lost."),
            title: Text("Warning!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  print(answerScore);

                  Navigator.pop(context, true);
                },
              ),
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          );
        });
  }

  void _nextSubmit() async {
    if (_selectedAnswer == null || _selectedAnswer == '') {
      _key.currentState.showSnackBar(SnackBar(
        content: Text("You must select an answer to continue."),
      ));
      return;
    }
    if (_currentIndex < (quiz.question.length - 1)) {
      setState(() {
        _currentIndex++;
        _selectedAnswer = '';
        _answer = null;
        _onChanged();
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => QuizResultScreen(
                quizScore: answerScore,
                questions: quiz.question,
                answers: quiz.answers,
              )));
    }
  }
}
