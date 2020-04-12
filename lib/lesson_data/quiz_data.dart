import 'package:ielts/models/quiz.dart';

List getQuizData() {
  return [
    Quiz(quizTitle: 'First Quiz', indicatorValue: 0.3, question: [
      'What does I am coming through actually mean',
      'Is United the best team in the world'
    ], options: [
      ["Taco Bello", "Minnesota", "Arkansas", "Arizona"],
      ["1", "2"]
    ], answers: [
      'arkansas',
      '2'
    ]),
  ];
}
