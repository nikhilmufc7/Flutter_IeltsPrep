import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ielts/app_constants.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;
String userId;

String userImage =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTP6HBlxRaCn7CViHiZrhpx1Sx4GHM-dafYZZjW0eizMFidSQRS&usqp=CAU';

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  // Checking if email and name is null
  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoUrl != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoUrl;
  userId = user.uid;

  // Only taking the first part of the name, i.e., First Name
  if (name.contains(" ")) {
    name = name.substring(0, name.indexOf(" "));
  }
  Firestore.instance.collection('users').document(user.uid).setData({
    "uid": user.uid,
    "firstName": name,
    "email": user.email,
    "userImage": user.photoUrl
  });

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded: $user';
}

Future<String> signIn(String email, String password) async {
  AuthResult result =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
  FirebaseUser user = result.user;
  name = user.displayName;
  email = user.email;
  userId = user.uid;

  return user.uid;
}

Future<String> signUp(String email, String password, String firstName) async {
  AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: email, password: password);
  FirebaseUser user = result.user;
  name = user.displayName;
  email = user.email;

  Firestore.instance.collection('users').document(user.uid).setData({
    "uid": user.uid,
    "firstName": firstName,
    "email": email,
    "userImage": userImage,
  });
  return user.uid;
}

void signOutGoogle(context) async {
  await _auth.signOut();
  await googleSignIn.signOut();
  Navigator.pushReplacementNamed(context, RoutePaths.login);

  print("User Sign Out");
}
