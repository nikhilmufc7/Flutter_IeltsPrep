import 'package:ielts/models/quiz.dart';

List getQuizData() {
  return [
    Quiz(quizTitle: 'First Quiz', indicatorValue: 0.3, question: [
      'What does I am coming through actually mean',
      'Is United the best team in the world'
    ], options: {
      "0": {"0": "Arkansas", "1": "Nile", "2": "Ganges", "3": "Narmada"},
      "1": {"0": "New", "1": "Another one"}
    }, answers: [
      'Arkansas',
      'New'
    ]),
  ];
}
