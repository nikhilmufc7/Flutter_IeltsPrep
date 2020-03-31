import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String firstName;
  String photoUrl;
  String uid;

  User.data([this.email, this.firstName, this.photoUrl, this.uid]) {
    this.email ??= '';
    this.firstName ??= '';
    this.photoUrl ??= '';
    this.uid ??= '';
  }

  factory User.from(DocumentSnapshot document) => User.data(
        document.data['email'],
        document.data['firstName'],
        document.data['userImage'],
        document.data['uid'],
      );

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'firstName': firstName,
      'userImage': photoUrl,
      'uid': uid,
    };
  }
}
