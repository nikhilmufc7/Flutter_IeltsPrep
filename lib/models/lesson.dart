// writing data
class Lesson {
  String id;
  String title;
  String level;
  double indicatorValue;
  String question;
  String answer;
  String image;

  Lesson(
      {this.id,
      this.title,
      this.level,
      this.indicatorValue,
      this.question,
      this.answer,
      this.image});

  Lesson.fromMap(Map snapshot, String id)
      : id = snapshot['id'] ?? '',
        title = snapshot['title'] ?? '',
        level = snapshot['level'] ?? '',
        indicatorValue = snapshot['indicatorValue'] ?? '',
        question = snapshot['question'] ?? '',
        answer = snapshot['answer'] ?? '',
        image = snapshot['image'] ?? '';

  toJson() {
    return {
      "id": id,
      "title": title,
      "level": level,
      "indicatorValue": indicatorValue,
      "question": question,
      "answer": answer,
      "image": image,
    };
  }
}
