import 'package:cloud_firestore/cloud_firestore.dart';

class ReadingApi {
  final Firestore _db = Firestore.instance;
  final String path;
  CollectionReference ref;

  DocumentReference docpath;

  ReadingApi(this.path) {
    ref = _db.collection(path);
  }

  // sentence

  Future<QuerySnapshot> getSentenceCollection() {
    return ref.document('sentence').collection('sentence').getDocuments();
  }

  Stream<QuerySnapshot> streamSentenceCollection() {
    return ref.document('sentence').collection('sentence').snapshots();
  }

  Future<DocumentReference> addSentenceDocument(Map data) {
    return ref.document('sentence').collection('sentence').add(data);
  }

  //true of false

  Future<QuerySnapshot> getTrueOrFalseCollection() {
    return ref.document('trueorfalse').collection('trueorfalse').getDocuments();
  }

  Stream<QuerySnapshot> streamTrueOrFalseCollection() {
    return ref.document('trueorfalse').collection('trueorfalse').snapshots();
  }

  Future<DocumentReference> addTrueOrFalseDocument(Map data) {
    return ref.document('trueorfalse').collection('trueorfalse').add(data);
  }

  // heading completion

  Future<QuerySnapshot> getHeadingCompletionCollection() {
    return ref
        .document('headingcompletion')
        .collection('headingcompletion')
        .getDocuments();
  }

  Stream<QuerySnapshot> streamHeadingCompletionCollection() {
    return ref
        .document('headingcompletion')
        .collection('headingcompletion')
        .snapshots();
  }

  Future<DocumentReference> addHeadingCompletionDocument(Map data) {
    return ref
        .document('headingcompletion')
        .collection('headingcompletion')
        .add(data);
  }

  // summary completion

  Future<QuerySnapshot> getSummaryCompletionCollection() {
    return ref
        .document('summarycompletion')
        .collection('summarycompletion')
        .getDocuments();
  }

  Stream<QuerySnapshot> streamSummaryCompletionCollection() {
    return ref
        .document('summarycompletion')
        .collection('summarycompletion')
        .snapshots();
  }

  Future<DocumentReference> addSummaryCompletionDocument(Map data) {
    return ref
        .document('summarycompletion')
        .collection('summarycompletion')
        .add(data);
  }

  // Paragraph

  Future<QuerySnapshot> getParagraphCompletionCollection() {
    return ref
        .document('paragraphcompletion')
        .collection('paragraphcompletion')
        .getDocuments();
  }

  Stream<QuerySnapshot> streamParagraphCompletionCollection() {
    return ref
        .document('paragraphcompletion')
        .collection('paragraphcompletion')
        .snapshots();
  }

  Future<DocumentReference> addParagraphCompletionDocument(Map data) {
    return ref
        .document('paragraphcompletion')
        .collection('paragraphcompletion')
        .add(data);
  }

  // MCQs

  Future<QuerySnapshot> getMCQsCollection() {
    return ref.document('mcqs').collection('mcqs').getDocuments();
  }

  Stream<QuerySnapshot> streamMCQsCollection() {
    return ref.document('mcqs').collection('mcqs').snapshots();
  }

  Future<DocumentReference> addMCQsDocument(Map data) {
    return ref.document('mcqs').collection('mcqs').add(data);
  }

  // List Selection

  Future<QuerySnapshot> getListSelectionCollection() {
    return ref
        .document('listselection')
        .collection('listselection')
        .getDocuments();
  }

  Stream<QuerySnapshot> streamListSelectionCollection() {
    return ref
        .document('listselection')
        .collection('listselection')
        .snapshots();
  }

  Future<DocumentReference> addListSelectionDocument(Map data) {
    return ref.document('listselection').collection('listselection').add(data);
  }

  // title Selection

  Future<QuerySnapshot> getTitleSelectionCollection() {
    return ref
        .document('titleselection')
        .collection('titleselection')
        .getDocuments();
  }

  Stream<QuerySnapshot> streamTitleSelectionCollection() {
    return ref
        .document('titleselection')
        .collection('titleselection')
        .snapshots();
  }

  Future<DocumentReference> addTitleSelectionDocument(Map data) {
    return ref
        .document('titleselection')
        .collection('titleselection')
        .add(data);
  }

  // categorization

  Future<QuerySnapshot> getCategorizationCollection() {
    return ref
        .document('categorization')
        .collection('categorization')
        .getDocuments();
  }

  Stream<QuerySnapshot> streamCategorizationCollection() {
    return ref
        .document('categorization')
        .collection('categorization')
        .snapshots();
  }

  Future<DocumentReference> addCategorizationDocument(Map data) {
    return ref
        .document('categorization')
        .collection('categorization')
        .add(data);
  }

  // ending Selection

  Future<QuerySnapshot> getEndingSelectionCollection() {
    return ref
        .document('endingselection')
        .collection('endingselection')
        .getDocuments();
  }

  Stream<QuerySnapshot> streamEndingSelectionCollection() {
    return ref
        .document('endingselection')
        .collection('endingselection')
        .snapshots();
  }

  Future<DocumentReference> addEndingSelectionDocument(Map data) {
    return ref
        .document('endingselection')
        .collection('endingselection')
        .add(data);
  }

  //saqs

  Future<QuerySnapshot> getSAQsCollection() {
    return ref.document('saqs').collection('saqs').getDocuments();
  }

  Stream<QuerySnapshot> streamSAQsCollection() {
    return ref.document('saqs').collection('saqs').snapshots();
  }

  Future<DocumentReference> addSAQsDocument(Map data) {
    return ref.document('saqs').collection('saqs').add(data);
  }
}
