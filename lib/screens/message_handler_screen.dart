import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class MessageHandler extends StatefulWidget {
  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  List<Message> _messages;

  _getToken() {
    _fcm.getToken().then((deviceToken) => print("Device token : $deviceToken"));
  }

  _configureFirebaseListeners() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _setMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _setMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("On resume : $message");
        _setMessage(message);
      },
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    final String mMessage = data['message'];

    setState(() {
      Message m = Message(title, body, mMessage);
      _messages.add(m);
    });
  }

  @override
  void initState() {
    super.initState();
    _messages = List<Message>();
    _fcm.requestNotificationPermissions(IosNotificationSettings());
    _getToken();
    _configureFirebaseListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}
