import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'package:ielts/models/listening.dart';
import 'package:ielts/screens/listening_detail_screen.dart';
import 'package:ielts/viewModels/listeningCrudModel.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color backgroundColor = Color(0xFF21BFBD);

class ListeningScreen extends StatefulWidget {
  ListeningScreen({Key key}) : super(key: key);

  @override
  _ListeningScreenState createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen>
    with SingleTickerProviderStateMixin {
  List listening;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);

  List<String> checkedListeningItems = [];

  void _getcheckedListeningItems() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('checkedListeningItems')) {
      checkedListeningItems = prefs.getStringList('checkedListeningItems');
    } else {
      prefs.setStringList('checkedListeningItems', checkedListeningItems);
    }
  }

  @override
  void initState() {
    _getcheckedListeningItems();
    super.initState();

    // listening = getListeningData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      appBar: topAppBar,
      body: Stack(
        children: <Widget>[
          // MenuPage(),
          dashboard(context),
        ],
      ),
    );
  }

  Widget dashboard(context) {
    final productProvider = Provider.of<ListeningCrudModel>(context);
    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),
      elevation: 8,
      color: backgroundColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   mainAxisSize: MainAxisSize.max,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 18.0),
              //       child: InkWell(
              //         child: Icon(Icons.arrow_back, color: Colors.white),
              //         onTap: () {
              //           Navigator.pop(context);
              //         },
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 18.0),
              //       child: Icon(Icons.settings, color: Colors.white),
              //     ),
              //   ],
              // ),

              Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Row(
                  children: <Widget>[
                    Text('Listening Exercises',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0)),
                    SizedBox(width: 10.0),
                    // Text('Prep',
                    //     style: TextStyle(
                    //         fontFamily: 'Montserrat',
                    //         color: Colors.white,
                    //         fontSize: 25.0))
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(75.0)),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: productProvider.fetchListeningAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          listening = snapshot.data.documents
                              .map((doc) =>
                                  Listening.fromMap(doc.data, doc.documentID))
                              .toList();

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: listening.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedListeningItems();
                              return makeCard(listening[index]);
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final topAppBar = AppBar(
    elevation: 0.0,
    backgroundColor: Color(0xFF21BFBD),
    bottomOpacity: 0.0,
  );

  Widget makeCard(Listening listening) => Padding(
        padding: const EdgeInsets.only(bottom: 15.0, left: 5, right: 5),
        child: Card(
          color: Color.fromRGBO(64, 75, 96, .9),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: makeListTile(listening),
        ),
      );

  ListTile makeListTile(Listening listening) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          listening.title,
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  // tag: 'hero',
                  child: LinearProgressIndicator(
                      backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                      value: listening.indicatorValue,
                      valueColor: AlwaysStoppedAnimation(Colors.green)),
                )),
            Expanded(
              flex: 4,
              child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(listening.level,
                      style: TextStyle(color: Colors.white))),
            )
          ],
        ),
        trailing: FittedBox(
          child: CheckboxGroup(
              checked: checkedListeningItems,
              labels: [listening.id],
              labelStyle: TextStyle(fontSize: 0),
              onSelected: (List<String> checked) {
                print("${checked.toString()}");
              },
              onChange: (bool isChecked, String label, int index) async {
                print(label);
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool(label, isChecked);
                print(prefs.getBool(label) ?? 0);

                setState(() {
                  isChecked = prefs.getBool(label);

                  if (checkedListeningItems.contains(label)) {
                    checkedListeningItems.remove(label);
                  } else {
                    checkedListeningItems.add(label);
                  }
                  prefs.setStringList(
                      'checkedListeningItems', checkedListeningItems);
                  print(checkedListeningItems);
                });
              }),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ListeningDetailScreen(listening: listening)));
        },
      );
}
