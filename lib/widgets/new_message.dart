import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String documentId;
  NewMessage({Key key, this.documentId}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _newMessage = '';

  final _controller = TextEditingController();

  void _send() async {
    FocusScope.of(context).unfocus();
    _controller.clear();
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance
        .collection('forums')
        .document(widget.documentId)
        .collection('chats')
        .add({
      'text': _newMessage,
      'sentAt': Timestamp.now(),
      'userId': user.uid,
      'firstName': userData['firstName'],
      'userImage': userData['userImage'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            textCapitalization: TextCapitalization.sentences,
            autocorrect: true,
            enableSuggestions: true,
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter a message',
            ),
            onChanged: (value) {
              setState(() {
                _newMessage = value;
              });
            },
          )),
          IconButton(
              icon: Icon(Icons.send),
              onPressed: _newMessage.trim().isEmpty ? null : _send)
        ],
      ),
    );
  }
}
