import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ielts/widgets/message.dart';
import 'package:ielts/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  final String documentId;
  const ChatScreen({Key key, this.documentId}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    print(widget.documentId);

    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
    fbm.subscribeToTopic('chats');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                })
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: MessagesWidget(
                documentId: widget.documentId,
              )),
              NewMessage(
                documentId: widget.documentId,
              )
            ],
          ),
        ));
  }
}
