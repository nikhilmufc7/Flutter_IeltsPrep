import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ielts/models/listening.dart';
import 'package:ielts/widgets/player_widget.dart';

final Color backgroundColor = Color(0xFF21BFBD);

class ListeningDetailScreen extends StatefulWidget {
  final Listening listening;
  ListeningDetailScreen({
    Key key,
    this.listening,
  }) : super(key: key);

  @override
  _ListeningDetailScreenState createState() =>
      _ListeningDetailScreenState(listening);
}

class _ListeningDetailScreenState extends State<ListeningDetailScreen>
    with SingleTickerProviderStateMixin {
  final Listening listening;
  _ListeningDetailScreenState(this.listening);

  String s1SubQuestions1Result;
  String s1SubQuestions2Result;
  String s1SubQuestions3Result;
  String answersResult;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
      advancedPlayer.startHeadlessService();
    }
  }

  @override
  void dispose() {
    advancedPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
          title: FittedBox(
            child: Text(listening.title),
          ),
          bottom: TabBar(
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
                    child: Text("Section 1"),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Section 2"),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Section 3",
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Section 4"),
                  ),
                ),
              ]),
        ),
        body: TabBarView(children: [
          Material(
            elevation: 8.0,
            animationDuration: duration,
            color: Theme.of(context).primaryColor,
            child: ListView(
              padding: EdgeInsets.only(bottom: 0, top: 20),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
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
                    child: ListView(
                      padding: EdgeInsets.only(top: 50),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.whatToDo.replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            // StreamBuilder(builder: (context, snapshot) {
                            //   return PlayerWidget(
                            //     url: listening.firstSectionAudio,
                            //     mode: PlayerMode.LOW_LATENCY,
                            //   );
                            // }),

                            PlayerWidget(url: listening.firstSectionAudio),

                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.intialQuestionNumbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            Visibility(
                              visible: (listening.firstQuestionImage != '')
                                  ? true
                                  : false,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: listening.firstQuestionImage,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            // Summary
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.s1SubQuestions1Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.s1SubQuestions1Bool == true,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: listening.s1SubQuestions1.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      s1SubQuestions1Result =
                                          listening.s1SubQuestions1[index];
                                      return ListTile(
                                        title: Text(
                                          s1SubQuestions1Result.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),

                            Visibility(
                              visible: listening.s1SubQuestions2Bool == true,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  listening.s1SubQuestions2Numbers
                                      .replaceAll("_n", "\n"),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ),

                            Visibility(
                              visible:
                                  listening.secondQuestionImageBool == true,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: listening.secondQuestionImage,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.s1SubQuestions2Bool == true,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: listening.s1SubQuestions2.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      s1SubQuestions2Result =
                                          listening.s1SubQuestions2[index];
                                      return ListTile(
                                        title: Text(
                                          s1SubQuestions2Result.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
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
                                  openAnswersSheet(context, listening);
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
                        ),

                        // section 2

                        //

                        //
                      ],
                    )),
              ],
            ),
          ),

          // 2 Section and Tab

          //

          //

          Material(
            elevation: 8.0,
            animationDuration: duration,
            color: Theme.of(context).primaryColor,
            child: ListView(
              padding: EdgeInsets.only(bottom: 0, top: 20),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
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
                    child: ListView(
                      padding: EdgeInsets.only(top: 50),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.s2WhatToDo.replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            PlayerWidget(url: listening.section2Audio),

                            SizedBox(height: 15),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.s2SubQuestion1Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            Visibility(
                              visible: listening.section2Image1Bool == true,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: listening.section2Image1,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.s2SubQuestions1Bool == true,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: listening.s2SubQuestions1.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      s1SubQuestions1Result =
                                          listening.s2SubQuestions1[index];
                                      return ListTile(
                                        title: Text(
                                          s1SubQuestions1Result.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                            // Summary
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.s2SubQuestion2Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section2Image2Bool == true,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: listening.section2Image2,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.s2SubQuestions2Bool == true,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: listening.s2SubQuestions2.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      s1SubQuestions2Result =
                                          listening.s2SubQuestions2[index];
                                      return ListTile(
                                        title: Text(
                                          s1SubQuestions2Result.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
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
                                  openSection2AnswersSheet(context, listening);
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
                        ),

                        //
                      ],
                    )),
              ],
            ),
          ),

          // section 3 and tab 3

          //

          //

          Material(
            elevation: 8.0,
            animationDuration: duration,
            color: Theme.of(context).primaryColor,
            child: ListView(
              padding: EdgeInsets.only(bottom: 0, top: 20),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
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
                    child: ListView(
                      padding: EdgeInsets.only(top: 50),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        //

                        ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.s3WhatToDo.replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            PlayerWidget(url: listening.section3Audio),

                            SizedBox(height: 15),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.section3Question1Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            Visibility(
                              visible: listening.section3Image1Bool == true,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: listening.section3Image1,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.section3Question1bool == true,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        listening.section3Question1.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      s1SubQuestions1Result =
                                          listening.section3Question1[index];
                                      return ListTile(
                                        title: Text(
                                          s1SubQuestions1Result.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                            // Summary
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.section3Question2Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section3Image2bool == true,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: listening.section3Image2,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.section3Questions2bool == true,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        listening.section3Question2.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      s1SubQuestions2Result =
                                          listening.section3Question2[index];
                                      return ListTile(
                                        title: Text(
                                          s1SubQuestions2Result.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.section3Question3Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section3Image3bool == true,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: listening.section3Image3,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.section3Question3bool == true,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        listening.section3Question3.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      s1SubQuestions3Result =
                                          listening.section3Question3[index];
                                      return ListTile(
                                        title: Text(
                                          s1SubQuestions3Result.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
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
                                  openSection3AnswersSheet(context, listening);
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
                        ),
                      ],
                    )),
              ],
            ),
          ),

          // section 4

          //

          //

          Material(
            elevation: 8.0,
            animationDuration: duration,
            color: Theme.of(context).primaryColor,
            child: ListView(
              padding: EdgeInsets.only(bottom: 0, top: 20),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
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
                    child: ListView(
                      padding: EdgeInsets.only(top: 50),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        //

                        ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(top: 10, bottom: 20),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.s4WhatToDo.replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            PlayerWidget(url: listening.section4Audio),

                            SizedBox(height: 15),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.section4Question1Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section4Image1Bool == true,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: listening.section4Image1,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: listening.section4Question1Bool == true,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        listening.section4Question1.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      s1SubQuestions1Result =
                                          listening.section4Question1[index];
                                      return ListTile(
                                        title: Text(
                                          s1SubQuestions1Result.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                            // Summary
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.section4Question2Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section4Image2Bool == true,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: listening.section4Image2,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.section4Question2Bool == true,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        listening.section4Question2.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      s1SubQuestions2Result =
                                          listening.section4Question2[index];
                                      return ListTile(
                                        title: Text(
                                          s1SubQuestions2Result.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                listening.section4Question3Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section4Question3Bool == true,
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 10),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        listening.section4Question3.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      s1SubQuestions3Result =
                                          listening.section4Question3[index];
                                      return ListTile(
                                        title: Text(
                                          s1SubQuestions3Result.replaceAll(
                                              "_n", "\n"),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
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
                                  openSection4AnswersSheet(context, listening);
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
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void openAnswersSheet(BuildContext context, Listening listening) {
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
                itemCount: listening.answers.length,
                itemBuilder: (BuildContext context, int index) {
                  answersResult = listening.answers[index];
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

  void openSection2AnswersSheet(BuildContext context, Listening listening) {
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
                itemCount: listening.section2Answers.length,
                itemBuilder: (BuildContext context, int index) {
                  answersResult = listening.section2Answers[index];
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

  // section 3 answer sheet

  void openSection3AnswersSheet(BuildContext context, Listening listening) {
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
                itemCount: listening.section3Answers.length,
                itemBuilder: (BuildContext context, int index) {
                  answersResult = listening.section3Answers[index];
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

  // SECTION 4 ANSWER SHEET

  void openSection4AnswersSheet(BuildContext context, Listening listening) {
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
                itemCount: listening.section4Answers.length,
                itemBuilder: (BuildContext context, int index) {
                  answersResult = listening.section4Answers[index];
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

  Widget bullet() => Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ));
}
