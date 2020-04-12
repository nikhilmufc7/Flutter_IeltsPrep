import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ielts/locator.dart';
import 'package:ielts/models/reading.dart';
import 'package:ielts/services/readingApi.dart';

class ReadingCrudModel extends ChangeNotifier {
  ReadingApi _api = locator<ReadingApi>();
  List<Reading> reading;

  // sentence collection

  Future<List<Reading>> fetchSentenceCollection() async {
    var result = await _api.getSentenceCollection();
    reading = result.documents
        .map((doc) => Reading.fromMap(doc.data, doc.documentID))
        .toList();
    return reading;
  }

  Stream<QuerySnapshot> fetchSentenceCollectionAsStream() {
    return _api.streamSentenceCollection();
  }

  // True Or false

  Future<List<Reading>> fetchTrueOrFalse() async {
    var result = await _api.getTrueOrFalseCollection();
    reading = result.documents
        .map((doc) => Reading.fromMap(doc.data, doc.documentID))
        .toList();
    return reading;
  }

  Stream<QuerySnapshot> fetchTrueOrFalseAsStream() {
    return _api.streamTrueOrFalseCollection();
  }

  // HeadingCompletion

  Future<List<Reading>> fetchHeadingCompletion() async {
    var result = await _api.getHeadingCompletionCollection();
    reading = result.documents
        .map((doc) => Reading.fromMap(doc.data, doc.documentID))
        .toList();
    return reading;
  }

  Stream<QuerySnapshot> fetchHeadingCompletionAsStream() {
    return _api.streamHeadingCompletionCollection();
  }

  // SummaryCompletion

  Future<List<Reading>> fetchSummaryCompletion() async {
    var result = await _api.getSummaryCompletionCollection();
    reading = result.documents
        .map((doc) => Reading.fromMap(doc.data, doc.documentID))
        .toList();
    return reading;
  }

  Stream<QuerySnapshot> fetchSummaryCompletionAsStream() {
    return _api.streamSummaryCompletionCollection();
  }

  // ParagraphCompletion

  Future<List<Reading>> fetchParagraphCompletion() async {
    var result = await _api.getParagraphCompletionCollection();
    reading = result.documents
        .map((doc) => Reading.fromMap(doc.data, doc.documentID))
        .toList();
    return reading;
  }

  Stream<QuerySnapshot> fetchParagraphCompletionAsStream() {
    return _api.streamParagraphCompletionCollection();
  }

  // MCQs

  Future<List<Reading>> fetchMCQs() async {
    var result = await _api.getMCQsCollection();
    reading = result.documents
        .map((doc) => Reading.fromMap(doc.data, doc.documentID))
        .toList();
    return reading;
  }

  Stream<QuerySnapshot> fetchMCQsAsStream() {
    return _api.streamMCQsCollection();
  }

  // ListSelection

  Future<List<Reading>> fetchListSelection() async {
    var result = await _api.getListSelectionCollection();
    reading = result.documents
        .map((doc) => Reading.fromMap(doc.data, doc.documentID))
        .toList();
    return reading;
  }

  Stream<QuerySnapshot> fetchListSelectionAsStream() {
    return _api.streamListSelectionCollection();
  }

  // TitleSelection

  Future<List<Reading>> fetchTitleSelection() async {
    var result = await _api.getTitleSelectionCollection();
    reading = result.documents
        .map((doc) => Reading.fromMap(doc.data, doc.documentID))
        .toList();
    return reading;
  }

  Stream<QuerySnapshot> fetchTitleSelectionAsStream() {
    return _api.streamTitleSelectionCollection();
  }

  // Categorization

  Future<List<Reading>> fetchCategorization() async {
    var result = await _api.getCategorizationCollection();
    reading = result.documents
        .map((doc) => Reading.fromMap(doc.data, doc.documentID))
        .toList();
    return reading;
  }

  Stream<QuerySnapshot> fetchCategorizationAsStream() {
    return _api.streamCategorizationCollection();
  }

  // EndingSelection

  Future<List<Reading>> fetchEndingSelection() async {
    var result = await _api.getEndingSelectionCollection();
    reading = result.documents
        .map((doc) => Reading.fromMap(doc.data, doc.documentID))
        .toList();
    return reading;
  }

  Stream<QuerySnapshot> fetchEndingSelectionAsStream() {
    return _api.streamEndingSelectionCollection();
  }

  // SAQs

  Future<List<Reading>> fetchSAQsSAQs() async {
    var result = await _api.getSAQsCollection();
    reading = result.documents
        .map((doc) => Reading.fromMap(doc.data, doc.documentID))
        .toList();
    return reading;
  }

  Stream<QuerySnapshot> fetchSAQsAsStream() {
    return _api.streamSAQsCollection();
  }
}
