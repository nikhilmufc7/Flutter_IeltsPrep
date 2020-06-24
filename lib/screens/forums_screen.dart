import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:ielts/widgets/forum_card.dart';

class ForumsScreen extends StatefulWidget {
  @override
  _ForumsScreenState createState() => _ForumsScreenState();
}

class _ForumsScreenState extends State<ForumsScreen> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController titleController = TextEditingController();

  var _newTitle = '';

  final List<String> _list = ['first', 'second', 'third'];
  List _items;

  bool _symmetry = false;
  bool _removeButton = true;
  bool _singleItem = false;
  bool _startDirection = false;
  bool _horizontalScroll = false;
  bool _withSuggesttions = false;
  int _count = 0;
  int _column = 0;
  double _fontSize = 14;

  String _itemCombine = 'withTextBefore';

  String _onPressed = '';

  List _icon = [Icons.home, Icons.language, Icons.headset];

  @override
  void initState() {
    super.initState();
    _items = _list.toList();
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
              child: Text(
                "Discussions",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                Center(
                  child: Text('Start a discussion'),
                ),
                TextField(
                  maxLength: 50,
                  onChanged: (text) {
                    setState(() {
                      _newTitle = text;
                    });
                  },
                ),
                Tags(
                  symmetry: _symmetry,
                  columns: _column,
                  horizontalScroll: _horizontalScroll,
                  //verticalDirection: VerticalDirection.up, textDirection: TextDirection.rtl,
                  heightHorizontalScroll: 60 * (_fontSize / 14),
                  itemCount: _items.length,
                  itemBuilder: (index) {
                    final item = _items[index];

                    return ItemTags(
                      key: Key(index.toString()),
                      index: index,
                      title: item,
                      pressEnabled: true,
                      activeColor: Colors.blueGrey[600],
                      singleItem: _singleItem,
                      splashColor: Colors.green,
                      combine: ItemTagsCombine.withTextBefore,
                      image: index > 0 && index < 5
                          ? ItemTagsImage(
                              //image: AssetImage("img/p$index.jpg"),
                              child: Image.network(
                              "http://www.clipartpanda.com/clipart_images/user-66327738/download",
                              width: 16 * _fontSize / 14,
                              height: 16 * _fontSize / 14,
                            ))
                          : (1 == 1
                              ? ItemTagsImage(
                                  image: NetworkImage(
                                      "https://d32ogoqmya1dw8.cloudfront.net/images/serc/empty_user_icon_256.v2.png"),
                                )
                              : null),
                      icon: (item == '0' || item == '1' || item == '2')
                          ? ItemTagsIcon(
                              icon: _icon[int.parse(item)],
                            )
                          : null,
                      removeButton: _removeButton
                          ? ItemTagsRemoveButton(
                              onRemoved: () {
                                setState(() {
                                  _items.removeAt(index);
                                });
                                return true;
                              },
                            )
                          : null,
                      textStyle: TextStyle(
                        fontSize: _fontSize,
                      ),
                      onPressed: (item) => print(item),
                    );
                  },
                ),
                RaisedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    titleController.clear();
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
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                )
              ],
            ));
  }
}
