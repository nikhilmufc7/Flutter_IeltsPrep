import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:ielts/models/speaking.dart';
import 'package:ielts/screens/speaking_detail_screen.dart';
import 'package:ielts/viewModels/speakingCrudModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color backgroundColor = Color(0xFF21BFBD);

class SpeakingScreen extends StatefulWidget {
  SpeakingScreen({Key key}) : super(key: key);

  @override
  _SpeakingScreenState createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen>
    with SingleTickerProviderStateMixin {
  List speakings;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);

  List<String> checkedSpeakingItems = [];

  void _getcheckedSpeakingItems() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('checkedSpeakingItems')) {
      checkedSpeakingItems = prefs.getStringList('checkedSpeakingItems');
    } else {
      prefs.setStringList('checkedSpeakingItems', checkedSpeakingItems);
    }
  }

  @override
  void initState() {
    _getcheckedSpeakingItems();
    super.initState();

    // speakings = getSpeakingData();
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        bottomOpacity: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          // MenuPage(),
          dashboard(context),
        ],
      ),
    );
  }

  Widget dashboard(context) {
    final productProvider = Provider.of<SpeakingCrudModel>(context);
    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),
      elevation: 8,
      color: Theme.of(context).primaryColor,
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
                    Text('Speaking Exercises',
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
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).secondaryHeaderColor,
                        blurRadius: 10)
                  ],
                  color: Theme.of(context).canvasColor,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(75.0)),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: productProvider.fetchSpeakingAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          speakings = snapshot.data.documents
                              .map((doc) =>
                                  Speaking.fromMap(doc.data, doc.documentID))
                              .toList();
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: speakings.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedSpeakingItems();
                              return makeCard(speakings[index]);
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

  Widget makeCard(Speaking speaking) => Padding(
        padding: const EdgeInsets.only(bottom: 15.0, left: 5, right: 5),
        child: Card(
          color: Color.fromRGBO(64, 75, 96, .9),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: makeListTile(speaking),
        ),
      );

  ListTile makeListTile(Speaking speaking) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          speaking.title,
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
                      value: speaking.indicatorValue,
                      valueColor: AlwaysStoppedAnimation(Colors.green)),
                )),
            Expanded(
              flex: 4,
              child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(speaking.level,
                      style: TextStyle(color: Colors.white))),
            )
          ],
        ),
        trailing: FittedBox(
          child: CheckboxGroup(
              checked: checkedSpeakingItems,
              checkColor: Colors.black,
              activeColor: Theme.of(context).secondaryHeaderColor,
              labels: [speaking.id],
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

                  if (checkedSpeakingItems.contains(label)) {
                    checkedSpeakingItems.remove(label);
                  } else {
                    checkedSpeakingItems.add(label);
                  }
                  prefs.setStringList(
                      'checkedSpeakingItems', checkedSpeakingItems);
                  print(checkedSpeakingItems);
                });
              }),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SpeakingDetailScreen(speaking: speaking)));
        },
      );
}
