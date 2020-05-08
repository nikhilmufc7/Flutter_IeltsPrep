import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:ielts/models/lesson.dart';
import 'package:ielts/screens/writing_detail_screen.dart';
import 'package:ielts/viewModels/writingCrudModel.dart';
import 'package:ielts/widgets/lessonCard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Color backgroundColor = Color(0xFF21BFBD);

class WritingScreen extends StatefulWidget {
  WritingScreen({Key key}) : super(key: key);

  @override
  _WritingScreenState createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen>
    with SingleTickerProviderStateMixin {
  List<Lesson> lessons;

  bool isCollapsed = true;
  double screenWidth, screenHeight;

  List<String> checkedWritingItems = [];
  final Duration duration = const Duration(milliseconds: 300);

  void _getcheckedWritingItems() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('checkedWritingItems')) {
      checkedWritingItems = prefs.getStringList('checkedWritingItems');
    } else {
      prefs.setStringList('checkedWritingItems', checkedWritingItems);
    }
  }

  @override
  void initState() {
    _getcheckedWritingItems();
    super.initState();
    // lessons = getWritingData();
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
        title: Text(
          'Writing Exercises',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        bottomOpacity: 0.0,
      ),
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => AddWriting()));
      //     }),
      body: Stack(
        children: <Widget>[
          // MenuPage(),
          dashboard(context),
        ],
      ),
    );
  }

  Widget dashboard(context) {
    final productProvider = Provider.of<CrudModel>(context);
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

              SizedBox(height: ScreenUtil().setHeight(20)),
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
                  child: StreamBuilder(
                      stream: productProvider.fetchLessonsAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          lessons = snapshot.data.documents
                              .map((doc) =>
                                  Lesson.fromMap(doc.data, doc.documentID))
                              .toList();

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(70),
                                bottom: ScreenUtil().setHeight(50)),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: lessons.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedWritingItems();
                              return makeCard(lessons[index]);
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
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

  Widget makeCard(Lesson lesson) => LessonCard(
        title: lesson.title,
        indicatorValue: lesson.indicatorValue,
        level: lesson.level,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WritingDetailScreen(lesson: lesson)));
        },
        trailing: FittedBox(
          child: CheckboxGroup(
              checked: checkedWritingItems,
              checkColor: Colors.black,
              activeColor: Colors.white,
              labels: [lesson.id],
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

                  if (checkedWritingItems.contains(label)) {
                    checkedWritingItems.remove(label);
                  } else {
                    checkedWritingItems.add(label);
                  }
                  prefs.setStringList(
                      'checkedWritingItems', checkedWritingItems);
                  print(checkedWritingItems);
                });
              }),
        ),
      );
}
