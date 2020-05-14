import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'package:ielts/models/reading.dart';
import 'package:ielts/screens/reading_detail_screen.dart';
import 'package:ielts/viewModels/readingCrudModel.dart';
import 'package:ielts/widgets/lessonCard.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadingScreen extends StatefulWidget {
  ReadingScreen({Key key}) : super(key: key);

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen>
    with TickerProviderStateMixin {
  List readings;
  List trueOrFalse;
  List headings;
  List summary;
  List paragraph;
  List mcqs;
  List listSelection;
  List titleSelection;
  List categorization;
  List matchingEndings;
  List saqs;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  TabController _tabController;

  List<String> checkedReadingItems = [];

  void _getcheckedReadingItems() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('checkedReadingItems')) {
      checkedReadingItems = prefs.getStringList('checkedReadingItems');
    } else {
      prefs.setStringList('checkedReadingItems', checkedReadingItems);
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 10, vsync: this);
    _getcheckedReadingItems();

    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);

    // readings = getReadingData();
    // trueOrFalse = getTrueFalseData();
    // headings = getHeadingData();
    // summary = getSummaryCompletionData();
    // paragraph = getParagraphMatching();
    // mcqs = getMCQs();
    // listSelection = getListSelectionData();
    // titleSelection = getTitleSelectionData();
    // categorization = getCategorizationData();
    // matchingEndings = getMatchingEndingsData();
    // saqs = getSAQs();
  }

  @override
  void dispose() {
    _controller.dispose();
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          'Reading Exercises',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          labelColor: Colors.white,
          labelStyle: TextStyle(
              fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(14)),
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(
              child: FittedBox(
                  child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                child: Text(
                  "True/ False",
                  textAlign: TextAlign.center,
                ),
              )),
            ),
            Tab(
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                  child: Text(
                    "Sentence \n Completion",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Tab(
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                  child: Text(
                    "Heading \n Completion",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Tab(
              child: FittedBox(
                  child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                child: Text(
                  "Summary \n Completion",
                  textAlign: TextAlign.center,
                ),
              )),
            ),
            Tab(
              child: FittedBox(
                  child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                child: Text(
                  "Matching \n Paragraphs",
                  textAlign: TextAlign.center,
                ),
              )),
            ),
            Tab(
              child: FittedBox(
                  child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                child: Text(
                  "MCQs",
                ),
              )),
            ),
            Tab(
              child: FittedBox(
                  child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                child: Text(
                  "List \n Selection",
                  textAlign: TextAlign.center,
                ),
              )),
            ),
            Tab(
              child: FittedBox(
                  child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                child: Text(
                  "Categorization",
                  textAlign: TextAlign.center,
                ),
              )),
            ),
            Tab(
              child: FittedBox(
                  child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                child: Text(
                  "Matching \n Endings",
                  textAlign: TextAlign.center,
                ),
              )),
            ),
            Tab(
              child: FittedBox(
                  child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                child: Text(
                  "Short \n Answers",
                  textAlign: TextAlign.center,
                ),
              )),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          TabBarView(
            children: [
              trueFalseDashBoard(context),
              sentenceDashboard(context),
              headingDashboard(context),
              summaryDashboard(context),
              paragraphDashboard(context),
              mcqDashboard(context),
              selectionDashboard(context),
              categoryDashboard(context),
              endingsDashboard(context),
              saqDashboard(context),
            ],
            controller: _tabController,
          ),
          // dashboard(context),
        ],
      ),
    );
  }

  Widget sentenceDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);
    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),

      color: Theme.of(context).primaryColor,

      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // SizedBox(height: ScreenUtil().setHeight(20)),
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(ScreenUtil().setWidth(45)),
                  // ),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: productProvider.fetchSentenceCollectionAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          readings = snapshot.data.documents
                              .map((doc) =>
                                  Reading.fromMap(doc.data, doc.documentID))
                              .toList();
                          print(snapshot.data.documents.length);

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40),
                                bottom: ScreenUtil().setHeight(50)),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: readings.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(readings[index]);
                            },
                          );
                        } else {
                          return Container(
                              height: screenHeight,
                              child:
                                  Center(child: CircularProgressIndicator()));
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

  Widget trueFalseDashBoard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),

      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(ScreenUtil().setHeight(45)),
                  // ),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder(
                      stream: productProvider.fetchTrueOrFalseAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          trueOrFalse = snapshot.data.documents
                              .map((doc) =>
                                  Reading.fromMap(doc.data, doc.documentID))
                              .toList();

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40),
                                bottom: ScreenUtil().setHeight(70)),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: trueOrFalse.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(trueOrFalse[index]);
                            },
                          );
                        } else {
                          return Container(
                              height: screenHeight,
                              child:
                                  Center(child: CircularProgressIndicator()));
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

  Widget headingDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),

      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(ScreenUtil().setHeight(45)),
                  // ),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder(
                      stream: productProvider.fetchHeadingCompletionAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          headings = snapshot.data.documents
                              .map((doc) =>
                                  Reading.fromMap(doc.data, doc.documentID))
                              .toList();

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40),
                                bottom: ScreenUtil().setHeight(70)),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: headings.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(headings[index]);
                            },
                          );
                        } else {
                          return Container(
                              height: screenHeight,
                              child:
                                  Center(child: CircularProgressIndicator()));
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

  Widget summaryDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),

      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(ScreenUtil().setHeight(45)),
                  // ),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder(
                      stream: productProvider.fetchSummaryCompletionAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          summary = snapshot.data.documents
                              .map((doc) =>
                                  Reading.fromMap(doc.data, doc.documentID))
                              .toList();
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40),
                                bottom: ScreenUtil().setHeight(70)),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: summary.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(summary[index]);
                            },
                          );
                        } else {
                          return Container(
                              height: screenHeight,
                              child:
                                  Center(child: CircularProgressIndicator()));
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

  Widget paragraphDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),

      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(ScreenUtil().setHeight(45)),
                  // ),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder(
                      stream:
                          productProvider.fetchParagraphCompletionAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          paragraph = snapshot.data.documents
                              .map((doc) =>
                                  Reading.fromMap(doc.data, doc.documentID))
                              .toList();
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40),
                                bottom: ScreenUtil().setHeight(70)),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: paragraph.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(paragraph[index]);
                            },
                          );
                        } else {
                          return Container(
                              height: screenHeight,
                              child:
                                  Center(child: CircularProgressIndicator()));
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

  Widget mcqDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),

      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(ScreenUtil().setHeight(45)),
                  // ),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder(
                      stream: productProvider.fetchMCQsAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          mcqs = snapshot.data.documents
                              .map((doc) =>
                                  Reading.fromMap(doc.data, doc.documentID))
                              .toList();
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40),
                                bottom: ScreenUtil().setHeight(70)),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: mcqs.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(mcqs[index]);
                            },
                          );
                        } else {
                          return Container(
                              height: screenHeight,
                              child:
                                  Center(child: CircularProgressIndicator()));
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

  Widget selectionDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),

      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(ScreenUtil().setHeight(45)),
                  // ),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder(
                      stream: productProvider.fetchListSelectionAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          listSelection = snapshot.data.documents
                              .map((doc) =>
                                  Reading.fromMap(doc.data, doc.documentID))
                              .toList();
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40),
                                bottom: ScreenUtil().setHeight(70)),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: listSelection.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(listSelection[index]);
                            },
                          );
                        } else {
                          return Container(
                              height: screenHeight,
                              child:
                                  Center(child: CircularProgressIndicator()));
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

  // Widget titleDashboard(context) {
  //   final productProvider = Provider.of<ReadingCrudModel>(context);

  //   return Material(
  //     animationDuration: duration,
  //     // borderRadius: BorderRadius.all(Radius.circular(40)),
  //
  //     color: Theme.of(context).primaryColor,
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.vertical,
  //       physics: ClampingScrollPhysics(),
  //       child: Container(
  //         padding: EdgeInsets.all(ScreenUtil().setHeight(48)),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             SizedBox(height: ScreenUtil().setHeight(40),),
  //             Container(
  //               // height: MediaQuery.of(context).size.height,
  //               decoration: BoxDecoration(
  //                 boxShadow: [
  //                   BoxShadow(
  //                       color: Theme.of(context).secondaryHeaderColor,
  //                       blurRadius: 10)
  //                 ],
  //                 color: Theme.of(context).canvasColor,
  //                 borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(75.0),
  //                     topRight: Radius.circular(75.0)),
  //               ),
  //               child: Container(
  //                 // height: screenHeight,
  //                 child: StreamBuilder(
  //                     stream: productProvider.fetchTitleSelectionAsStream(),
  //                     builder:
  //                         (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //                       if (snapshot.hasData) {
  //                         titleSelection = snapshot.data.documents
  //                             .map((doc) =>
  //                                 Reading.fromMap(doc.data, doc.documentID))
  //                             .toList();
  //                         return ListView.builder(
  //                           scrollDirection: Axis.vertical,
  //                           padding: EdgeInsets.only(top: ScreenUtil().setHeight(40), bottom: ScreenUtil().setHeight(70)),
  //                           shrinkWrap: true,
  //                           physics: ScrollPhysics(),
  //                           itemCount: titleSelection.length,
  //                           itemBuilder: (BuildContext context, int index) {
  //                             _getcheckedReadingItems();
  //                             return makeCard(titleSelection[index]);
  //                           },
  //                         );
  //                       } else {
  //                         return CircularProgressIndicator();
  //                       }
  //                     }),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget categoryDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),

      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(ScreenUtil().setHeight(45)),
                  // ),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder(
                      stream: productProvider.fetchCategorizationAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          categorization = snapshot.data.documents
                              .map((doc) =>
                                  Reading.fromMap(doc.data, doc.documentID))
                              .toList();
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40),
                                bottom: ScreenUtil().setHeight(70)),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: categorization.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return Container(
                                  height: screenHeight,
                                  child: Center(
                                      child: CircularProgressIndicator()));
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

  Widget endingsDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),

      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          // padding: EdgeInsets.all(ScreenUtil().setHeight(48)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(ScreenUtil().setHeight(45)),
                  // ),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder(
                      stream: productProvider.fetchEndingSelectionAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          matchingEndings = snapshot.data.documents
                              .map((doc) =>
                                  Reading.fromMap(doc.data, doc.documentID))
                              .toList();
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40),
                                bottom: ScreenUtil().setHeight(70)),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: matchingEndings.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(matchingEndings[index]);
                            },
                          );
                        } else {
                          return Container(
                              height: screenHeight,
                              child:
                                  Center(child: CircularProgressIndicator()));
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

  Widget saqDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

    return Material(
      animationDuration: duration,
      // borderRadius: BorderRadius.all(Radius.circular(40)),

      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          // padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(ScreenUtil().setHeight(45)),
                  // ),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder(
                      stream: productProvider.fetchSAQsAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          saqs = snapshot.data.documents
                              .map((doc) =>
                                  Reading.fromMap(doc.data, doc.documentID))
                              .toList();
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: ScreenUtil().setHeight(40),
                                bottom: ScreenUtil().setHeight(70)),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: saqs.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(saqs[index]);
                            },
                          );
                        } else {
                          return Container(
                              height: screenHeight,
                              child:
                                  Center(child: CircularProgressIndicator()));
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

  Widget makeCard(Reading reading) => LessonCard(
        title: reading.title,
        indicatorValue: reading.indicatorValue,
        level: reading.level,
        trailing: FittedBox(
          child: CheckboxGroup(
              checked: checkedReadingItems,
              checkColor: Colors.white,
              activeColor: Colors.black,
              labels: [reading.id],
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

                  if (checkedReadingItems.contains(label)) {
                    checkedReadingItems.remove(label);
                  } else {
                    checkedReadingItems.add(label);
                  }
                  prefs.setStringList(
                      'checkedReadingItems', checkedReadingItems);
                  print(checkedReadingItems);
                });
              }),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReadingDetailScreen(reading: reading)));
        },
      );

  // ListTile makeListTile(Reading reading) =>
}
