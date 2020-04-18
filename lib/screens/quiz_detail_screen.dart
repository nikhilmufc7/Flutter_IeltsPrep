import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:ielts/lesson_data/quiz_data.dart';
import 'package:ielts/models/quiz.dart';

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

  _onChanged() {
    setState(() {
      _isRadioEnabled = !_isRadioEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map options = quiz.options["$_currentIndex"];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          key: _key,
          appBar: AppBar(
            title: Text('Quiz'),
            elevation: 0,
          ),
          body: Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  height: 200,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(16.0),
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
                        SizedBox(width: 16.0),
                        Expanded(
                            child: Text(
                          quiz.question[_currentIndex],
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )),
                      ],
                    ),
                    SizedBox(height: 25.0),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: options.keys.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Color.fromRGBO(204, 224, 255, 0.8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: RadioListTile(
                                    activeColor: Colors.deepPurpleAccent,
                                    title: Text(
                                      options["$index"],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    value: options["$index"],
                                    groupValue: _selectedAnswer,
                                    onChanged: _isRadioEnabled
                                        ? (value) {
                                            setState(() {
                                              _selectedAnswer = value;
                                              if (_selectedAnswer ==
                                                  quiz.answers[_currentIndex]) {
                                                answerScore = answerScore + 1;
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
                              );
                            }),
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: <Widget>[
                        Visibility(
                            visible: _answer != null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (_answer == 'Answer is right, well done!')
                                        ? '${parser.emojify(':wink:')}'
                                        : '${parser.emojify(':disappointed:')} ',
                                    style: TextStyle(fontSize: 36),
                                  ),
                                ),
                                Container(
                                    width: 220,
                                    padding: EdgeInsets.all(10),
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
                                            fontSize: 14,
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    parser.emojify(':heart:'),
                                    style: TextStyle(fontSize: 36),
                                  ),
                                ),
                                Container(
                                  width: 220,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.cyanAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    ' Correct Answer is ${quiz.answers[_currentIndex]} ',
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(height: 10),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        _currentIndex == (quiz.question.length - 1)
                            ? "Submit"
                            : "Next",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      color: Colors.deepPurpleAccent,
                      onPressed: _nextSubmit,
                    )
                  ])),
            ],
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

  void _nextSubmit() {
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
      // Navigator.of(context).pushReplacement(MaterialPageRoute(
      //   builder: (_) => QuizFinishedPage(questions: widget.questions, answers: _answers)
      // ));
    }
  }
}
