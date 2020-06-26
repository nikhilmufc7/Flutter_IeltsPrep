import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ielts/widgets/message_bubble.dart';

class MessagesWidget extends StatelessWidget {
  final String documentId;
  const MessagesWidget({Key key, this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamBuilder(
            stream: Firestore.instance
                .collection('forums')
                .document(documentId)
                .collection('chats')
                .orderBy('sentAt', descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final chatDocuments = snapshot.data.documents;

              return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (ctx, index) => MessageBubble(
                        message: chatDocuments[index]['text'],
                        isMe: chatDocuments[index]['userId'] ==
                            futureSnapshot.data.uid,
                        key: ValueKey(chatDocuments[index].documentID),
                        firstName: chatDocuments[index]['firstName'],
                        imageUrl: chatDocuments[index]['userImage'],
                        time: chatDocuments[index]['sentAt'].toDate(),
                      ));
            },
          );
        });
  }
}
