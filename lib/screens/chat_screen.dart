import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts/widgets/message.dart';
import 'package:ielts/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  final String documentId;
  final String title;
  const ChatScreen({Key key, this.documentId, this.title}) : super(key: key);

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
        backgroundColor: Theme.of(context).indicatorColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).indicatorColor,
          elevation: 0,
          title: AutoSizeText(
            widget.title,
            minFontSize: 13,
            maxFontSize: 26,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.sanchez(fontSize: 24),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).splashColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, right: 10),
            child: Column(
              children: [
                Expanded(
                    child: MessagesWidget(
                  documentId: widget.documentId,
                )),
                SizedBox(
                  height: 10,
                ),
                NewMessage(
                  documentId: widget.documentId,
                )
              ],
            ),
          ),
        ));
  }
}
