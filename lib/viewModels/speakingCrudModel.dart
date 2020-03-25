import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ielts/locator.dart';
import 'package:ielts/models/speaking.dart';

import 'package:ielts/services/speakingApi.dart';

class SpeakingCrudModel extends ChangeNotifier {
  SpeakingApi _api = locator<SpeakingApi>();
  List<Speaking> speaking;

  Future<List<Speaking>> fetchSpeaking() async {
    var result = await _api.getDataCollection();
    speaking = result.documents
        .map((doc) => Speaking.fromMap(doc.data, doc.documentID))
        .toList();
    return speaking;
  }

  Stream<QuerySnapshot> fetchSpeakingAsStream() {
    return _api.streamDataCollection();
  }

  Future<Speaking> getSpeakingById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Speaking.fromMap(doc.data, doc.documentID);
  }

  Future removeSpeaking(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateSpeaking(Speaking data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addSpeaking(Speaking data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
