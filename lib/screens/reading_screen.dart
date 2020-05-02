import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    _tabController = TabController(length: 11, vsync: this);
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
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading Exercises'),
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        bottomOpacity: 0.8,
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          labelColor: Colors.redAccent,
          unselectedLabelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          tabs: [
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text("True/ False")),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(
                  child: Text(
                    "Sentence \n Completion",
                  ),
                ),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text("Heading \n Completion")),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text("Summary \n Completion")),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text("Matching \n Paragraphs")),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text("MCQs")),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text("List \n Selection")),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text("Title \n Selection")),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text("Categorization")),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text("Matching \n Endings")),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: FittedBox(child: Text("Short \n Answers")),
              ),
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
              titleDashboard(context),
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0)),
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
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: readings.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(readings[index]);
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

  Widget trueFalseDashBoard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0)),
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
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: trueOrFalse.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(trueOrFalse[index]);
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

  Widget headingDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0)),
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
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: headings.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(headings[index]);
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

  Widget summaryDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0)),
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
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: summary.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(summary[index]);
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

  Widget paragraphDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0)),
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
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: paragraph.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(paragraph[index]);
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

  Widget mcqDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0)),
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
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: mcqs.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(mcqs[index]);
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

  Widget selectionDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0)),
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
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: listSelection.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(listSelection[index]);
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

  Widget titleDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0)),
                ),
                child: Container(
                  // height: screenHeight,
                  child: StreamBuilder(
                      stream: productProvider.fetchTitleSelectionAsStream(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          titleSelection = snapshot.data.documents
                              .map((doc) =>
                                  Reading.fromMap(doc.data, doc.documentID))
                              .toList();
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: titleSelection.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(titleSelection[index]);
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

  Widget categoryDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0)),
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
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: categorization.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(categorization[index]);
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0)),
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
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: matchingEndings.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(matchingEndings[index]);
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

  Widget saqDashboard(context) {
    final productProvider = Provider.of<ReadingCrudModel>(context);

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(75.0),
                      topRight: Radius.circular(75.0)),
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
                            padding: EdgeInsets.only(top: 70, bottom: 50),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: saqs.length,
                            itemBuilder: (BuildContext context, int index) {
                              _getcheckedReadingItems();
                              return makeCard(saqs[index]);
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

  Widget makeCard(Reading reading) => LessonCard(
        title: reading.title,
        indicatorValue: reading.indicatorValue,
        level: reading.level,
        trailing: FittedBox(
          child: CheckboxGroup(
              checked: checkedReadingItems,
              checkColor: Colors.black,
              activeColor: Theme.of(context).secondaryHeaderColor,
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
