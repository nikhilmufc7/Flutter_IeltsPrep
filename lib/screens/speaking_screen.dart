import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:ielts/models/speaking.dart';
import 'package:ielts/screens/speaking_detail_screen.dart';
import 'package:ielts/viewModels/speakingCrudModel.dart';
import 'package:ielts/widgets/lessonCard.dart';
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
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
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
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                child: Row(
                  children: <Widget>[
                    Text('Speaking Exercises',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(25),
                        )),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(40)),
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).secondaryHeaderColor,
                        blurRadius: 10)
                  ],
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenUtil().setWidth(75))),
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
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(70),
                                bottom: ScreenUtil().setHeight(50)),
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

  Widget makeCard(Speaking speaking) => LessonCard(
        title: speaking.title,
        indicatorValue: speaking.indicatorValue,
        level: speaking.level,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SpeakingDetailScreen(speaking: speaking)));
        },
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
      );
}
