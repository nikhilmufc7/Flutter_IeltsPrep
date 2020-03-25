class Reading {
  String id;
  String title;
  String level;
  double indicatorValue;
  List initialQuestions;
  List endingQuestions;
  String paragraph;
  List answers;
  String intialQuestionNumbers;
  String endingQuestionNumbers;
  String whatToDo;
  bool extraData;
  String summary;

  Reading({
    this.id,
    this.title,
    this.level,
    this.indicatorValue,
    this.initialQuestions,
    this.endingQuestions,
    this.extraData,
    this.paragraph,
    this.answers,
    this.intialQuestionNumbers,
    this.endingQuestionNumbers,
    this.whatToDo,
    this.summary,
  });

  Reading.fromMap(Map snapshot, String id)
      : id = snapshot['id'] ?? '',
        title = snapshot['title'] ?? '',
        level = snapshot['level'] ?? '',
        indicatorValue = snapshot['indicatorValue'] ?? '',
        initialQuestions = snapshot['initialQuestions'] ?? [],
        endingQuestions = snapshot['endingQuestions'] ?? [],
        extraData = snapshot['extraData'] ?? false,
        paragraph = snapshot['paragraph'] ?? '',
        answers = snapshot['answers'] ?? [],
        intialQuestionNumbers = snapshot['initialQuestionNumbers'] ?? '',
        endingQuestionNumbers = snapshot['endingQuestionNumbers'] ?? '',
        whatToDo = snapshot['whatToDo'] ?? '',
        summary = snapshot['summary'] ?? '';

  toJson() {
    return {
      "id": id,
      "title": title,
      "level": level,
      "indicatorValue": indicatorValue,
      "initialQuestions": initialQuestions,
      "endingQuestions": endingQuestions,
      "extraData": extraData,
      "paragraph": paragraph,
      "answers": answers,
      "initialQuestionNumbers": intialQuestionNumbers,
      "endingQuestionNumbers": endingQuestionNumbers,
      "whatToDo": whatToDo,
      "summary": summary,
    };
  }
}
