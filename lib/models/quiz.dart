class Quiz {
  List question;
  Map options;
  List answers;
  String quizTitle;
  double indicatorValue;

  Quiz({
    this.question,
    this.options,
    this.answers,
    this.quizTitle,
    this.indicatorValue,
  });

  Quiz.fromMap(Map<dynamic, dynamic> snapshot, String id)
      : question = snapshot['question'] ?? '',
        options = snapshot['options'] ?? {},
        answers = snapshot['answers'] ?? [],
        quizTitle = snapshot['quizTitle'] ?? '',
        indicatorValue = snapshot['indicatorValue'] ?? '';

  toJson() {
    return {
      "question": question,
      "options": options,
      "answers": answers,
      "quizTitle": quizTitle,
      "indicatorValue": indicatorValue,
    };
  }
}
