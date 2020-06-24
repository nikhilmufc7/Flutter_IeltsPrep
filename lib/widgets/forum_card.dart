import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts/screens/chat_screen.dart';
import 'package:ielts/widgets/circular_image.dart';

import 'package:intl/intl.dart';

class ForumCard extends StatefulWidget {
  @override
  _ForumCardState createState() => _ForumCardState();
}

class _ForumCardState extends State<ForumCard> {
  String uid = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var _tapPosition;

  getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;

    print(uid);
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('forums')
          .orderBy('sentAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final chatDocuments = snapshot.data.documents;

        return ListView.builder(
            itemCount: chatDocuments.length,
            itemBuilder: (ctx, index) => InkWell(
                  onTapDown: _storePosition,
                  onLongPress: () {
                    final RenderBox overlay =
                        Overlay.of(context).context.findRenderObject();

                    showMenu(
                        context: context,
                        position: RelativeRect.fromRect(
                            _tapPosition &
                                Size(40, 40), // smaller rect, the touch area
                            Offset.zero &
                                overlay.size // Bigger rect, the entire screen
                            ),
                        items: <PopupMenuEntry<Widget>>[
                          PopupMenuItem(
                            child: IconButton(
                                icon: Icon(uid == chatDocuments[index]['userId']
                                    ? Icons.delete
                                    : null),
                                onPressed: () async {
                                  await Firestore.instance.runTransaction(
                                      (Transaction myTransaction) async {
                                    await myTransaction.delete(snapshot
                                        .data.documents[index].reference);
                                    Navigator.pop(context);
                                  });
                                }),
                          )
                        ]);
                  },
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                documentId:
                                    snapshot.data.documents[index].documentID,
                              ))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ListTile(
                            title: Padding(
                              padding:
                                  EdgeInsets.only(left: 8.0, top: 8, bottom: 8),
                              child: AutoSizeText(chatDocuments[index]['title'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.pangolin(fontSize: 20)),
                            ),
                            subtitle: Wrap(
                              spacing: 8,
                              children: List<Widget>.generate(
                                  chatDocuments[index]['tags'].length,
                                  (tagindex) {
                                return Chip(
                                    backgroundColor: Colors.deepPurpleAccent,
                                    label: AutoSizeText(
                                      chatDocuments[index]['tags'][tagindex],
                                      style: TextStyle(color: Colors.white),
                                    ));
                              }),
                            ),
                            trailing: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  chatDocuments[index]['userImage']),
                            ),
                          ),
                          ListTile(
                              subtitle: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  DateFormat('dd-MMMM   HH:mm').format(
                                    chatDocuments[index]['sentAt'].toDate(),
                                  ),
                                  style: GoogleFonts.gochiHand(fontSize: 20),
                                ),
                              ),
                              trailing: AutoSizeText(
                                'Started by: ${chatDocuments[index]['firstName']}',
                                maxLines: 1,
                                style: GoogleFonts.pangolin(fontSize: 16),
                              ))
                        ],
                      ),
                    ),
                  ),
                ));
      },
    );
  }

  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }
}
