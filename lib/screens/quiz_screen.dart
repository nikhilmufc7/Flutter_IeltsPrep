import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:ielts/lesson_data/quiz_data.dart';
import 'package:ielts/models/quiz.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({Key key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List quiz;

  final TextStyle _questionStyle = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.white);
  int _currentIndex = 0;
  int _optionsIndex = 0;

  String _answer;
  String _selectedAnswer;

  @override
  void initState() {
    super.initState();
    quiz = getQuizData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
              _question(quiz[0])
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

  Widget _question(Quiz quiz) {
    final List<dynamic> options = quiz.options[_currentIndex];

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white70,
                child: Text("${_currentIndex + 1}"),
              ),
              SizedBox(width: 16.0),
              Expanded(child: Text(quiz.question[_currentIndex])),
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            child: Flexible(
              child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(options[index]),
                      leading: Radio(
                          value: options[index],
                          groupValue: _selectedAnswer,
                          onChanged: (value) {
                            setState(() {
                              _selectedAnswer = value;
                              if (_selectedAnswer ==
                                  quiz.answers[_currentIndex]) {
                                _answer = 'Answer is right';
                                print(_answer);
                              } else {
                                _answer = 'Your answer is wrong';
                                print(_answer);
                              }
                            });
                          }),
                    );
                  }),
            ),
          ),
          RaisedButton(
            color: Colors.deepPurpleAccent,
            onPressed: () {
              setState(() {
                _currentIndex++;
                print(_currentIndex);
              });
            },
          )
        ]));
  }
}
