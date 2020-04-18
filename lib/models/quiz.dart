class Quiz {
  List question;
  Map options;
  List answers;
  String quizTitle;
  double indicatorValue;
  bool isFeatured;
  int id;

  Quiz({
    this.question,
    this.options,
    this.answers,
    this.quizTitle,
    this.indicatorValue,
    this.isFeatured,
    this.id,
  });

  Quiz.fromMap(Map<dynamic, dynamic> snapshot, String id)
      : question = snapshot['question'] ?? '',
        options = snapshot['options'] ?? {},
        answers = snapshot['answers'] ?? [],
        quizTitle = snapshot['quizTitle'] ?? '',
        indicatorValue = snapshot['indicatorValue'] ?? '',
        isFeatured = snapshot['isFeatured'] ?? '',
        id = snapshot['id'] ?? '';

  toJson() {
    return {
      "question": question,
      "options": options,
      "answers": answers,
      "quizTitle": quizTitle,
      "indicatorValue": indicatorValue,
      "isFeatured": isFeatured,
      "id": id,
    };
  }
}
