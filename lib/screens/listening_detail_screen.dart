import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/models/listening.dart';
import 'package:ielts/screens/home_screen.dart';
import 'package:ielts/services/admob_service.dart';
import 'package:ielts/widgets/seekBar.dart';
import 'package:just_audio/just_audio.dart';

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

  final ams = AdMobService();

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = Duration(milliseconds: 300);

  AudioPlayer _player;
  AudioPlayer _player2;
  AudioPlayer _player3;
  AudioPlayer _player4;

  @override
  void initState() {
    _player = AudioPlayer();
    _player.setUrl(listening.firstSectionAudio).catchError((error) {
      // catch audio error ex: 404 url, wrong url ...
      print(error);
    });

    // preloading 2nd section audio

    _player2 = AudioPlayer();
    _player2.setUrl(listening.section2Audio).catchError((error) {
      // catch audio error ex: 404 url, wrong url ...
      print(error);
    });

    // preloading 3rd section audio

    _player3 = AudioPlayer();
    _player3.setUrl(listening.section3Audio).catchError((error) {
      // catch audio error ex: 404 url, wrong url ...
      print(error);
    });

    // preloading 4th section audio

    _player4 = AudioPlayer();
    _player4.setUrl(listening.section4Audio).catchError((error) {
      // catch audio error ex: 404 url, wrong url ...
      print(error);
    });

    super.initState();
    Admob.initialize(ams.getAdMobAppId());
  }

  @override
  void dispose() {
    _player.dispose();
    _player2.dispose();
    _player3.dispose();
    _player4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​450*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              }),
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
          title: FittedBox(
            child: Text(
              listening.title,
              style: TextStyle(color: Colors.white),
            ),
          ),
          bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenUtil().setSp(14)),
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                      child: FittedBox(
                        child: Text(
                          "Section 1",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                      child: FittedBox(
                        child: Text(
                          "Section 2",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                      child: FittedBox(
                        child: Text(
                          "Section 3",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                      child: FittedBox(
                        child: Text(
                          "Section 4",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
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
              padding:
                  EdgeInsets.only(bottom: 0, top: ScreenUtil().setHeight(20)),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                    // height: MediaQuery.of(context).size.height,

                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),
                    child: ListView(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(10),
                              bottom: ScreenUtil().setHeight(20)),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.whatToDo.replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            StreamBuilder<FullAudioPlaybackState>(
                              stream: _player.fullPlaybackStateStream,
                              builder: (context, snapshot) {
                                final fullState = snapshot.data;
                                final state = fullState?.state;
                                final buffering = fullState?.buffering;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (state ==
                                            AudioPlaybackState.connecting ||
                                        buffering == true)
                                      Container(
                                        margin: EdgeInsets.all(8.0),
                                        width: 45.0,
                                        height: 45.0,
                                        child: CircularProgressIndicator(),
                                      )
                                    else if (state ==
                                        AudioPlaybackState.playing)
                                      Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.pause),
                                            color: Colors.deepPurpleAccent,
                                            iconSize: 45.0,
                                            onPressed: _player.pause,
                                          ),
                                          Text(
                                            'Pause',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ],
                                      )
                                    else
                                      Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.play_arrow),
                                            iconSize: 45.0,
                                            color: Colors.deepPurpleAccent,
                                            onPressed: () {
                                              _player2.stop();
                                              _player3.stop();
                                              _player4.stop();
                                              _player.play();
                                            },
                                          ),
                                          Text(
                                            'Play',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ],
                                      ),
                                    Column(
                                      children: <Widget>[
                                        StreamBuilder<Duration>(
                                          stream: _player.durationStream,
                                          builder: (context, snapshot) {
                                            final duration =
                                                snapshot.data ?? Duration.zero;
                                            return StreamBuilder<Duration>(
                                              stream:
                                                  _player.getPositionStream(),
                                              builder: (context, snapshot) {
                                                var position = snapshot.data ??
                                                    Duration.zero;
                                                if (position > duration) {
                                                  position = duration;
                                                }
                                                return SeekBar(
                                                  duration: duration,
                                                  position: position,
                                                  onChangeEnd: (newPosition) {
                                                    _player.seek(newPosition);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        if (state ==
                                                AudioPlaybackState.connecting ||
                                            buffering == true)
                                          Text(
                                            'Loading audio...',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        Container(
                                          height: 0,
                                          width: 0,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.stop),
                                          color: Colors.deepPurpleAccent,
                                          iconSize: 45.0,
                                          onPressed: state ==
                                                      AudioPlaybackState
                                                          .stopped ||
                                                  state ==
                                                      AudioPlaybackState.none
                                              ? null
                                              : _player.stop,
                                        ),
                                        Text(
                                          'Stop',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),

                            SizedBox(height: ScreenUtil().setHeight(20)),
                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.intialQuestionNumbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            Visibility(
                              visible: premium_user != true,
                              child: AdmobBanner(
                                  adUnitId: ams.getBannerAdId(),
                                  adSize: AdmobBannerSize.FULL_BANNER),
                            ),
                            Visibility(
                              visible: (listening.firstQuestionImage != '')
                                  ? true
                                  : false,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setWidth(10)),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CachedNetworkImage(
                                    imageUrl: listening.firstQuestionImage,
                                    placeholder: (context, url) => SizedBox(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('assets/transparent.gif'),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      children: <Widget>[
                                        Icon(Icons.error),
                                        Text(
                                            'Please check your internet connection')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Summary
                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.s1SubQuestions1Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.s1SubQuestions1Bool == true,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10),
                                      top: ScreenUtil().setHeight(10)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
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
                                            fontSize: ScreenUtil().setSp(12),
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
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(8)),
                                child: Text(
                                  listening.s1SubQuestions2Numbers
                                      .replaceAll("_n", "\n"),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(14),
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ),

                            Visibility(
                              visible:
                                  listening.secondQuestionImageBool == true,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(10)),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CachedNetworkImage(
                                    imageUrl: listening.secondQuestionImage,
                                    placeholder: (context, url) => SizedBox(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('assets/transparent.gif'),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      children: <Widget>[
                                        Icon(Icons.error),
                                        Text(
                                            'Please check your internet connection')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.s1SubQuestions2Bool == true,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10),
                                      top: ScreenUtil().setHeight(10)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
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
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),

                            Visibility(
                              visible: premium_user != true,
                              child: AdmobBanner(
                                  adUnitId: ams.getBannerAdId(),
                                  adSize: AdmobBannerSize.BANNER),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  openAnswersSheet(context, listening);
                                },
                                child: Text('Answers',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(20),
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
              padding:
                  EdgeInsets.only(bottom: 0, top: ScreenUtil().setHeight(20)),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                    // height: MediaQuery.of(context).size.height,

                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),
                    child: ListView(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(10),
                              bottom: ScreenUtil().setHeight(20)),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.s2WhatToDo.replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            SizedBox(height: ScreenUtil().setHeight(15)),

                            StreamBuilder<FullAudioPlaybackState>(
                              stream: _player2.fullPlaybackStateStream,
                              builder: (context, snapshot) {
                                final fullState = snapshot.data;
                                final state = fullState?.state;
                                final buffering = fullState?.buffering;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (state ==
                                            AudioPlaybackState.connecting ||
                                        buffering == true)
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.all(8.0),
                                            width: 45.0,
                                            height: 45.0,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ],
                                      )
                                    else if (state ==
                                        AudioPlaybackState.playing)
                                      Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.pause),
                                            color: Colors.deepPurpleAccent,
                                            iconSize: 45.0,
                                            onPressed: _player2.pause,
                                          ),
                                          Text(
                                            'Pause',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ],
                                      )
                                    else
                                      Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.play_arrow),
                                            iconSize: 45.0,
                                            color: Colors.deepPurpleAccent,
                                            onPressed: () {
                                              _player.stop();
                                              _player3.stop();
                                              _player4.stop();
                                              _player2.play();
                                            },
                                          ),
                                          Text(
                                            'Play',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ],
                                      ),
                                    Column(
                                      children: <Widget>[
                                        StreamBuilder<Duration>(
                                          stream: _player2.durationStream,
                                          builder: (context, snapshot) {
                                            final duration =
                                                snapshot.data ?? Duration.zero;
                                            return StreamBuilder<Duration>(
                                              stream:
                                                  _player2.getPositionStream(),
                                              builder: (context, snapshot) {
                                                var position = snapshot.data ??
                                                    Duration.zero;
                                                if (position > duration) {
                                                  position = duration;
                                                }
                                                return SeekBar(
                                                  duration: duration,
                                                  position: position,
                                                  onChangeEnd: (newPosition) {
                                                    _player2.seek(newPosition);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        if (state ==
                                                AudioPlaybackState.connecting ||
                                            buffering == true)
                                          Text(
                                            'Loading audio...',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        Container(
                                          height: 0,
                                          width: 0,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.stop),
                                          color: Colors.deepPurpleAccent,
                                          iconSize: 45.0,
                                          onPressed: state ==
                                                      AudioPlaybackState
                                                          .stopped ||
                                                  state ==
                                                      AudioPlaybackState.none
                                              ? null
                                              : _player2.stop,
                                        ),
                                        Text(
                                          'Stop',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),

                            SizedBox(height: ScreenUtil().setHeight(20)),

                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.s2SubQuestion1Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            Visibility(
                              visible: listening.section2Image1Bool == true,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(10)),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CachedNetworkImage(
                                    imageUrl: listening.section2Image1,
                                    placeholder: (context, url) => SizedBox(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('assets/transparent.gif'),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      children: <Widget>[
                                        Icon(Icons.error),
                                        Text(
                                            'Please check your internet connection')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.s2SubQuestions1Bool == true,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10),
                                      top: ScreenUtil().setHeight(10)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
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
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                            // Summary
                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.s2SubQuestion2Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section2Image2Bool == true,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(10)),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CachedNetworkImage(
                                    imageUrl: listening.section2Image2,
                                    placeholder: (context, url) => SizedBox(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('assets/transparent.gif'),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      children: <Widget>[
                                        Icon(Icons.error),
                                        Text(
                                            'Please check your internet connection')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.s2SubQuestions2Bool == true,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10),
                                      top: ScreenUtil().setHeight(10)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
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
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),

                            Visibility(
                              visible: premium_user != true,
                              child: AdmobBanner(
                                  adUnitId: ams.getBannerAdId(),
                                  adSize: AdmobBannerSize.BANNER),
                            ),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setWidth(10))),
                                onPressed: () {
                                  openSection2AnswersSheet(context, listening);
                                },
                                child: Text('Answers',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(18),
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
              padding: EdgeInsets.only(
                  // left: ScreenUtil().setWidth(10),
                  // right: ScreenUtil().setWidth(10),
                  top: ScreenUtil().setHeight(10)),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                    // height: MediaQuery.of(context).size.height,

                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),
                    child: ListView(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        //

                        ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(10),
                              bottom: ScreenUtil().setHeight(20)),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.s3WhatToDo.replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            // PlayerWidget(url: listening.section3Audio),

                            StreamBuilder<FullAudioPlaybackState>(
                              stream: _player3.fullPlaybackStateStream,
                              builder: (context, snapshot) {
                                final fullState = snapshot.data;
                                final state = fullState?.state;
                                final buffering = fullState?.buffering;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (state ==
                                            AudioPlaybackState.connecting ||
                                        buffering == true)
                                      Container(
                                        margin: EdgeInsets.all(8.0),
                                        width: 45.0,
                                        height: 45.0,
                                        child: CircularProgressIndicator(),
                                      )
                                    else if (state ==
                                        AudioPlaybackState.playing)
                                      Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.pause),
                                            color: Colors.deepPurpleAccent,
                                            iconSize: 45.0,
                                            onPressed: _player3.pause,
                                          ),
                                          Text(
                                            'Pause',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ],
                                      )
                                    else
                                      Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.play_arrow),
                                            iconSize: 45.0,
                                            color: Colors.deepPurpleAccent,
                                            onPressed: () {
                                              _player.stop();
                                              _player2.stop();
                                              _player4.stop();
                                              _player3.play();
                                            },
                                          ),
                                          Text(
                                            'Play',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ],
                                      ),
                                    Column(
                                      children: <Widget>[
                                        StreamBuilder<Duration>(
                                          stream: _player3.durationStream,
                                          builder: (context, snapshot) {
                                            final duration =
                                                snapshot.data ?? Duration.zero;
                                            return StreamBuilder<Duration>(
                                              stream:
                                                  _player3.getPositionStream(),
                                              builder: (context, snapshot) {
                                                var position = snapshot.data ??
                                                    Duration.zero;
                                                if (position > duration) {
                                                  position = duration;
                                                }
                                                return SeekBar(
                                                  duration: duration,
                                                  position: position,
                                                  onChangeEnd: (newPosition) {
                                                    _player3.seek(newPosition);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        if (state ==
                                                AudioPlaybackState.connecting ||
                                            buffering == true)
                                          Text(
                                            'Loading audio...',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        Container(
                                          height: 0,
                                          width: 0,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.stop),
                                          color: Colors.deepPurpleAccent,
                                          iconSize: 45.0,
                                          onPressed: state ==
                                                      AudioPlaybackState
                                                          .stopped ||
                                                  state ==
                                                      AudioPlaybackState.none
                                              ? null
                                              : _player.stop,
                                        ),
                                        Text(
                                          'Stop',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),

                            SizedBox(height: ScreenUtil().setHeight(20)),

                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.section3Question1Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                            Visibility(
                              visible: premium_user != true,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: AdmobBanner(
                                    adUnitId: ams.getBannerAdId(),
                                    adSize: AdmobBannerSize.FULL_BANNER),
                              ),
                            ),
                            Visibility(
                              visible: listening.section3Image1Bool == true,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(10)),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CachedNetworkImage(
                                    imageUrl: listening.section3Image1,
                                    placeholder: (context, url) => SizedBox(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('assets/transparent.gif'),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      children: <Widget>[
                                        Icon(Icons.error),
                                        Text(
                                            'Please check your internet connection')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.section3Question1bool == true,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10),
                                      top: ScreenUtil().setHeight(10)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
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
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                            // Summary
                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.section3Question2Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section3Image2bool == true,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(10)),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CachedNetworkImage(
                                    imageUrl: listening.section3Image2,
                                    placeholder: (context, url) => SizedBox(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('assets/transparent.gif'),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      children: <Widget>[
                                        Icon(Icons.error),
                                        Text(
                                            'Please check your internet connection')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.section3Questions2bool == true,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10),
                                      top: ScreenUtil().setHeight(10)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
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
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),

                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.section3Question3Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section3Image3bool == true,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(10)),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CachedNetworkImage(
                                    imageUrl: listening.section3Image3,
                                    placeholder: (context, url) => SizedBox(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('assets/transparent.gif'),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      children: <Widget>[
                                        Icon(Icons.error),
                                        Text(
                                            'Please check your internet connection')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.section3Question3bool == true,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10),
                                      top: ScreenUtil().setHeight(10)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
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
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),

                            Visibility(
                              visible: premium_user != true,
                              child: AdmobBanner(
                                  adUnitId: ams.getBannerAdId(),
                                  adSize: AdmobBannerSize.BANNER),
                            ),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setHeight(10))),
                                onPressed: () {
                                  openSection3AnswersSheet(context, listening);
                                },
                                child: Text('Answers',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(18),
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
              padding: EdgeInsets.only(
                  // left: ScreenUtil().setWidth(10),
                  // right: ScreenUtil().setWidth(10),
                  top: ScreenUtil().setHeight(10)),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Container(
                    // height: MediaQuery.of(context).size.height,

                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                    ),
                    child: ListView(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(30)),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        //

                        ListView(
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(10),
                              bottom: ScreenUtil().setHeight(20)),
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.s4WhatToDo.replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            // PlayerWidget(url: listening.section4Audio),

                            StreamBuilder<FullAudioPlaybackState>(
                              stream: _player4.fullPlaybackStateStream,
                              builder: (context, snapshot) {
                                final fullState = snapshot.data;
                                final state = fullState?.state;
                                final buffering = fullState?.buffering;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (state ==
                                            AudioPlaybackState.connecting ||
                                        buffering == true)
                                      Container(
                                        margin: EdgeInsets.all(8.0),
                                        width: 45.0,
                                        height: 45.0,
                                        child: CircularProgressIndicator(),
                                      )
                                    else if (state ==
                                        AudioPlaybackState.playing)
                                      Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.pause),
                                            color: Colors.deepPurpleAccent,
                                            iconSize: 45.0,
                                            onPressed: _player4.pause,
                                          ),
                                          Text(
                                            'Pause',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ],
                                      )
                                    else
                                      Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.play_arrow),
                                            iconSize: 45.0,
                                            color: Colors.deepPurpleAccent,
                                            onPressed: () {
                                              _player2.stop();
                                              _player3.stop();
                                              _player.stop();
                                              _player4.play();
                                            },
                                          ),
                                          Text(
                                            'Play',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        ],
                                      ),
                                    Column(
                                      children: <Widget>[
                                        StreamBuilder<Duration>(
                                          stream: _player4.durationStream,
                                          builder: (context, snapshot) {
                                            final duration =
                                                snapshot.data ?? Duration.zero;
                                            return StreamBuilder<Duration>(
                                              stream:
                                                  _player4.getPositionStream(),
                                              builder: (context, snapshot) {
                                                var position = snapshot.data ??
                                                    Duration.zero;
                                                if (position > duration) {
                                                  position = duration;
                                                }
                                                return SeekBar(
                                                  duration: duration,
                                                  position: position,
                                                  onChangeEnd: (newPosition) {
                                                    _player4.seek(newPosition);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        if (state ==
                                                AudioPlaybackState.connecting ||
                                            buffering == true)
                                          Text(
                                            'Loading audio...',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Montserrat'),
                                          ),
                                        Container(
                                          height: 0,
                                          width: 0,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.stop),
                                          color: Colors.deepPurpleAccent,
                                          iconSize: 45.0,
                                          onPressed: state ==
                                                      AudioPlaybackState
                                                          .stopped ||
                                                  state ==
                                                      AudioPlaybackState.none
                                              ? null
                                              : _player4.stop,
                                        ),
                                        Text(
                                          'Stop',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),

                            SizedBox(height: ScreenUtil().setHeight(20)),

                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.section4Question1Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section4Image1Bool == true,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(10)),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: CachedNetworkImage(
                                    imageUrl: listening.section4Image1,
                                    placeholder: (context, url) => SizedBox(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('assets/transparent.gif'),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      children: <Widget>[
                                        Icon(Icons.error),
                                        Text(
                                            'Please check your internet connection')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: listening.section4Question1Bool == true,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10),
                                      top: ScreenUtil().setHeight(10)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
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
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),
                            // Summary
                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.section4Question2Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section4Image2Bool == true,
                              child: Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(10)),
                                child: FittedBox(
                                  child: CachedNetworkImage(
                                    imageUrl: listening.section4Image2,
                                    placeholder: (context, url) => SizedBox(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('assets/transparent.gif'),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      children: <Widget>[
                                        Icon(Icons.error),
                                        Text(
                                            'Please check your internet connection')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Visibility(
                              visible: listening.section4Question2Bool == true,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10),
                                      top: ScreenUtil().setHeight(10)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
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
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),

                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Text(
                                listening.section4Question3Numbers
                                    .replaceAll("_n", "\n"),
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(13),
                                    color: Theme.of(context).accentColor),
                              ),
                            ),

                            Visibility(
                              visible: listening.section4Question3Bool == true,
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(10),
                                      right: ScreenUtil().setWidth(10),
                                      top: ScreenUtil().setHeight(10)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
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
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                            ),

                            Visibility(
                              visible: premium_user != true,
                              child: AdmobBanner(
                                  adUnitId: ams.getBannerAdId(),
                                  adSize: AdmobBannerSize.BANNER),
                            ),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        ScreenUtil().setHeight(10))),
                                onPressed: () {
                                  openSection4AnswersSheet(context, listening);
                                },
                                child: Text('Answers',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(18),
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
              padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listening.answers.length,
                itemBuilder: (BuildContext context, int index) {
                  answersResult = listening.answers[index];
                  return ListTile(
                    title: Text(
                      answersResult.replaceAll("_n", "\n"),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: ScreenUtil().setSp(12),
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
              padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listening.section2Answers.length,
                itemBuilder: (BuildContext context, int index) {
                  answersResult = listening.section2Answers[index];
                  return ListTile(
                    title: Text(
                      answersResult.replaceAll("_n", "\n"),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: ScreenUtil().setSp(12),
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
              padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listening.section3Answers.length,
                itemBuilder: (BuildContext context, int index) {
                  answersResult = listening.section3Answers[index];
                  return ListTile(
                    title: Text(
                      answersResult.replaceAll("_n", "\n"),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: ScreenUtil().setSp(12),
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
              padding: EdgeInsets.all(ScreenUtil().setHeight(10)),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: listening.section4Answers.length,
                itemBuilder: (BuildContext context, int index) {
                  answersResult = listening.section4Answers[index];
                  return ListTile(
                    title: Text(
                      answersResult.replaceAll("_n", "\n"),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: ScreenUtil().setSp(12),
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
      height: ScreenUtil().setHeight(20),
      width: ScreenUtil().setWidth(20),
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ));
}
