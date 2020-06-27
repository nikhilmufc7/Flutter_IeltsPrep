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
    setState(() {
      _newMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).splashColor,
        border: Border(
          top: BorderSide(width: 1, color: Colors.lightBlue.shade50),
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: Container(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              maxLines: null,
              controller: _controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter a message',
                  hintStyle:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor)),
              onChanged: (value) {
                setState(() {
                  _newMessage = value;
                });
              },
            ),
          )),
          IconButton(
            icon: Icon(Icons.send),
            onPressed:
                _newMessage.trim().isEmpty || _newMessage == '' ? null : _send,
          )
        ],
      ),
    );
  }
}
