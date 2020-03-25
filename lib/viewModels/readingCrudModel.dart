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

  Future addSentenceCollection(Reading data) async {
    var result = await _api.addSentenceDocument(data.toJson());

    return;
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

  Future addTrueOrFalse(Reading data) async {
    var result = await _api.addTrueOrFalseDocument(data.toJson());

    return;
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

  Future addHeadingCompletion(Reading data) async {
    var result = await _api.addHeadingCompletionDocument(data.toJson());

    return;
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

  Future addSummaryCompletion(Reading data) async {
    var result = await _api.addSummaryCompletionDocument(data.toJson());

    return;
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

  Future addParagraphCompletion(Reading data) async {
    var result = await _api.addParagraphCompletionDocument(data.toJson());

    return;
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

  Future addMCQs(Reading data) async {
    var result = await _api.addMCQsDocument(data.toJson());

    return;
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

  Future addListSelection(Reading data) async {
    var result = await _api.addListSelectionDocument(data.toJson());

    return;
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

  Future addTitleSelection(Reading data) async {
    var result = await _api.addTitleSelectionDocument(data.toJson());

    return;
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

  Future addCategorization(Reading data) async {
    var result = await _api.addCategorizationDocument(data.toJson());

    return;
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

  Future addEndingSelection(Reading data) async {
    var result = await _api.addEndingSelectionDocument(data.toJson());

    return;
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

  Future addSAQs(Reading data) async {
    var result = await _api.addSAQsDocument(data.toJson());

    return;
  }
}
