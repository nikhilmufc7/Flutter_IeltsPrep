import 'package:ielts/models/quiz.dart';

List getQuizData() {
  return [
    Quiz(quizTitle: 'First Quiz', indicatorValue: 0.3, question: [
      'this',
      'another'
    ], options: [
      [
        "Taco Bello",
        "Minnesota",
        "arkansas",
      ],
      ["1", "2"]
    ], answers: [
      'arkansas',
      '2'
    ]),
  ];
}
