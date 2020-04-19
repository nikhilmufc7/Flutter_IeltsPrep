import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ielts/models/speaking.dart';

final Color backgroundColor = Color(0xFF21BFBD);

class SpeakingDetailScreen extends StatefulWidget {
  final Speaking speaking;
  SpeakingDetailScreen({
    Key key,
    this.speaking,
  }) : super(key: key);

  @override
  _SpeakingDetailScreenState createState() =>
      _SpeakingDetailScreenState(speaking);
}

class _SpeakingDetailScreenState extends State<SpeakingDetailScreen>
    with SingleTickerProviderStateMixin {
  final Speaking speaking;
  _SpeakingDetailScreenState(this.speaking);

  bool isCollapsed = true;
  String resultant;
  String vocabResult;
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
      appBar: topAppBar,
      body: Stack(
        children: <Widget>[
          // MenuPage(),
          Material(
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
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20),
                      child: FittedBox(
                        child: Text(speaking.title.replaceAll("_n", "\n"),
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
                        color: Colors.white,
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
                                  'Things to speak',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xFF21BFBD)),
                                ),
                              ),
                              Card(
                                elevation: 10,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10, top: 10),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: speaking.thingsToSpeak.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        resultant =
                                            speaking.thingsToSpeak[index];

                                        return ListTile(
                                          leading: bullet(),
                                          title: Text(
                                            resultant.replaceAll('_n', '\n'),
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      },
                                    )),
                              ),
                              SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Sample answer',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xFF21BFBD)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  speaking.answer.replaceAll("_n", "\n"),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Text(
                                    'Important Keywords for vocabulary',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color(0xFF21BFBD)),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: speaking.vocabulary.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      vocabResult = speaking.vocabulary[index];
                                      return ListTile(
                                        leading: bullet(),
                                        title: Text(
                                          vocabResult.replaceAll("_n", "\n"),
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
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

  // Widget dashboard(context) {
  //   CardController controller;
  //   return
  // }

  final topAppBar = AppBar(
    elevation: 0.0,
    backgroundColor: Color(0xFF21BFBD),
    bottomOpacity: 0.0,
  );

  Widget bullet() => Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ));
}
