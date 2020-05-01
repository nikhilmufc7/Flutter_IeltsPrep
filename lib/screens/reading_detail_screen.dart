import 'package:flutter/material.dart';
import 'package:ielts/models/reading.dart';

final Color backgroundColor = Color(0xFF21BFBD);

class ReadingDetailScreen extends StatefulWidget {
  final Reading reading;
  ReadingDetailScreen({
    Key key,
    this.reading,
  }) : super(key: key);

  @override
  _ReadingDetailScreenState createState() => _ReadingDetailScreenState(reading);
}

class _ReadingDetailScreenState extends State<ReadingDetailScreen>
    with SingleTickerProviderStateMixin {
  final Reading reading;
  _ReadingDetailScreenState(this.reading);

  String initialQuestionResult;
  String endingQuestionResult;
  String answersResult;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
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
          Material(
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
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20),
                      child: FittedBox(
                        child: Text(reading.title.replaceAll("_n", "\n"),
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0)),
                      ),

                      // Text('Prep',
                      //     style: TextStyle(
                      //         fontFamily: 'Montserrat',
                      //         color: Colors.white,
                      //         fontSize: 25.0))
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
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                              top: 40,
                            ),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  reading.whatToDo.replaceAll("_n", "\n \n"),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF21BFBD)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10, top: 10),
                                child: Text(
                                  reading.paragraph.replaceAll("_n", "\n"),
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  reading.intialQuestionNumbers
                                      .replaceAll("_n", "\n"),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(0xFF21BFBD)),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: reading.initialQuestions.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      initialQuestionResult =
                                          reading.initialQuestions[index];

                                      return ListTile(
                                        title: Text(
                                          initialQuestionResult.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                              // Summary
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  reading.summary.replaceAll("_n", "\n"),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).accentColor,
                                      fontSize: 16),
                                ),
                              ),

                              Visibility(
                                visible: reading.extraData == true,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    reading.endingQuestionNumbers
                                        .replaceAll("_n", "\n"),
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Color(0xFF21BFBD)),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: reading.extraData == true,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10, top: 10),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: reading.endingQuestions.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        endingQuestionResult =
                                            reading.endingQuestions[index];
                                        return ListTile(
                                          title: Text(
                                            endingQuestionResult.replaceAll(
                                                "_n", "\n"),
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () {
                                    openBookingDetailsSheet(context, reading);
                                  },
                                  child: const Text('Answers',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Montserrat',
                                      )),
                                  color: Colors.deepPurpleAccent,
                                  textColor: Colors.white,
                                  elevation: 5,
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void openBookingDetailsSheet(BuildContext context, Reading reading) {
    showModalBottomSheet<Widget>(
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) => ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: reading.answers.length,
                itemBuilder: (BuildContext context, int index) {
                  answersResult = reading.answers[index];
                  return ListTile(
                    title: Text(
                      answersResult.replaceAll("_n", "\n"),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
