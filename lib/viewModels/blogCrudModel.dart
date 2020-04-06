import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ielts/locator.dart';
import 'package:ielts/models/blog.dart';

import 'package:ielts/services/blogApi.dart';

class BlogCrudModel extends ChangeNotifier {
  BlogApi _api = locator<BlogApi>();
  List<Blog> blog;

  Future<List<Blog>> fetchLesson() async {
    var result = await _api.getDataCollection();
    blog = result.documents
        .map((doc) => Blog.fromMap(doc.data, doc.documentID))
        .toList();
    return blog;
  }

  Stream<QuerySnapshot> fetchBlogsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Blog> getBlogById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Blog.fromMap(doc.data, doc.documentID);
  }

  Future removeProduct(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateProduct(Blog data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addProduct(Blog data) async {
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
