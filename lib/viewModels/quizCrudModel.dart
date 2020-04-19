import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ielts/locator.dart';
import 'package:ielts/models/quiz.dart';
import 'package:ielts/services/quizApi.dart';

class QuizCrudModel extends ChangeNotifier {
  QuizApi _api = locator<QuizApi>();
  List<Quiz> quiz;

  Future<List<Quiz>> fetchQuiz() async {
    var result = await _api.getDataCollection();
    quiz = result.documents
        .map((doc) => Quiz.fromMap(doc.data, doc.documentID))
        .toList();
    return quiz;
  }

  Stream<QuerySnapshot> fetchQuizAsStream() {
    return _api.streamDataCollection();
  }

  Future<Quiz> getQuizById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Quiz.fromMap(doc.data, doc.documentID);
  }

  Future removeQuiz(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateQuiz(Quiz data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  // Future addQuiz(Quiz data) async {
  //   var result = await _api.addDocument(data.toJson());

  //   return;
  // }
}
