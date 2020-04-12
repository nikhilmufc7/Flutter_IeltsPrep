import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ielts/locator.dart';
import 'package:ielts/models/listening.dart';
import 'package:ielts/services/listeningApi.dart';

class ListeningCrudModel extends ChangeNotifier {
  ListeningApi _api = locator<ListeningApi>();
  List<Listening> listening;

  Future<List<Listening>> fetchListening() async {
    var result = await _api.getDataCollection();
    listening = result.documents
        .map((doc) => Listening.fromMap(doc.data, doc.documentID))
        .toList();
    return listening;
  }

  Stream<QuerySnapshot> fetchListeningAsStream() {
    return _api.streamDataCollection();
  }

  Future<Listening> getListeningById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Listening.fromMap(doc.data, doc.documentID);
  }

  Future removeListening(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateListening(Listening data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }
}
