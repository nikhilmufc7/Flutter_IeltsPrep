import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ielts/widgets/forum_card.dart';

class ForumsScreen extends StatefulWidget {
  @override
  _ForumsScreenState createState() => _ForumsScreenState();
}

class _ForumsScreenState extends State<ForumsScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController titleController = TextEditingController();

  var _newTitle = '';

  final List<String> _list = [
    'Mentor Help',
    'Discussion',
    'IELTS Exam',
    'Help Required',
    'Useful',
    'Speaking Buddy',
    'Information',
    'Tips',
    'Share knowledge',
    'Exam Dates',
    'Reading',
    'Listening',
    'Writing',
    'Speaking'
  ];
  List _items = [];

  bool _symmetry = false;

  bool _singleItem = false;
  bool _horizontalScroll = false;
  int _column = 0;
  double _fontSize = 14;
  GlobalKey<FormState> _formKey = GlobalKey();
  bool _errorVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context),
        child: Icon(Icons.add),
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: screenHeight / 10,
              width: screenWidth,
              color: Colors.orange,
              child: AutoSizeText(
                "Discussions",
                maxLines: 1,
                minFontSize: 16,
                maxFontSize: 32,
                textAlign: TextAlign.center,
                style: GoogleFonts.breeSerif(fontSize: 28),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: ForumCard(),
          ),
        ],
      ),
    );
  }

  void _showDialog(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (_) => Column(
              children: [
                Form(
                  key: _formKey,
                  child: AutoSizeText(
                    "Start a discussion",
                    maxLines: 1,
                    minFontSize: 16,
                    maxFontSize: 32,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.breeSerif(fontSize: 28),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(179, 179, 255, 0.2),
                      borderRadius: BorderRadius.circular(30)),
                  margin:
                      EdgeInsets.only(left: 10, right: 20, top: 30, bottom: 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Give a catchy title',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.child_care,
                            color: Color.fromRGBO(179, 179, 255, 1), size: 24)),
                    maxLength: 50,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    validator: (val) {
                      if (val.isEmpty || val.length < 5) {
                        return 'Please enter a title';
                      }
                    },
                    onChanged: (val) => _newTitle = val,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    "Select Tags (Max 2)",
                    maxLines: 1,
                    minFontSize: 14,
                    maxFontSize: 20,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.breeSerif(fontSize: 18),
                  ),
                ),
                Tags(
                  symmetry: _symmetry,
                  columns: _column,
                  horizontalScroll: _horizontalScroll,

                  //verticalDirection: VerticalDirection.up, textDirection: TextDirection.rtl,
                  heightHorizontalScroll: 60 * (_fontSize / 14),
                  itemCount: _list.length,
                  itemBuilder: (index) {
                    final item = _list[index];

                    return ItemTags(
                      key: Key(index.toString()),
                      index: index,
                      title: item,
                      active: true,
                      activeColor: Colors.blueGrey[600],
                      pressEnabled: true,
                      singleItem: _singleItem,
                      splashColor: Colors.green,
                      textStyle: TextStyle(
                        fontSize: _fontSize,
                      ),
                      onPressed: (item) => setState(() {
                        if (_items.length < 2 &&
                            _items.contains(item.title) == false) {
                          _items.add(item.title);

                          print(_items);
                        } else {
                          _items.remove(item.title);
                        }
                      }),
                    );
                  },
                ),
                Visibility(visible: _errorVisible, child: Text('Fix errors')),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    splashColor: Colors.greenAccent,
                    color: Colors.deepPurpleAccent,
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      if (_formKey.currentState.validate() &&
                          _items.length != 0) {
                        _formKey.currentState.save();
                        final user = await FirebaseAuth.instance.currentUser();
                        final userData = await Firestore.instance
                            .collection('users')
                            .document(user.uid)
                            .get();
                        Firestore.instance.collection('forums').add({
                          'title': _newTitle,
                          'sentAt': Timestamp.now(),
                          'userId': user.uid,
                          'firstName': userData['firstName'],
                          'userImage': userData['userImage'],
                          'tags': _items,
                        });
                        titleController.clear();
                        setState(() {
                          _items.clear();
                          _errorVisible = false;
                        });
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          _errorVisible = true;
                        });
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ));
  }
}
