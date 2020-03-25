class Speaking {
  String id;
  String title;
  String level;
  double indicatorValue;
  List thingsToSpeak;
  List vocabulary;
  String answer;

  Speaking({
    this.id,
    this.title,
    this.level,
    this.indicatorValue,
    this.thingsToSpeak,
    this.vocabulary,
    this.answer,
  });

  Speaking.fromMap(Map<dynamic, dynamic> snapshot, String id)
      : id = snapshot['id'] ?? '',
        title = snapshot['title'] ?? '',
        level = snapshot['level'] ?? '',
        indicatorValue = snapshot['indicatorValue'] ?? '',
        thingsToSpeak = snapshot['thingsToSpeak'] ?? '',
        vocabulary = snapshot['vocabulary'] ?? '',
        answer = snapshot['answer'] ?? '';
  // "thingsToSpeak": thingsToSpeak,

  // "vocabulary": vocabulary,

  toJson() {
    return {
      "id": id,
      "title": title,
      "level": level,
      "thingsToSpeak": thingsToSpeak,
      "vocabulary": vocabulary,
      "indicatorValue": indicatorValue,
      "answer": answer,
    };
  }
}
