import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ielts/models/speaking.dart';
import 'package:ielts/screens/home_screen.dart';
import 'package:ielts/services/admob_service.dart';

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

enum TtsState { playing, stopped }

class _SpeakingDetailScreenState extends State<SpeakingDetailScreen>
    with SingleTickerProviderStateMixin {
  FlutterTts flutterTts;

  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  TtsState ttsState = TtsState.stopped;

  final ams = AdMobService();

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

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
    initTts();
    Admob.initialize(ams.getAdMobAppId());
  }

  initTts() {
    flutterTts = FlutterTts();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (speaking.answer != null) {
      if (speaking.answer.isNotEmpty) {
        var result = await flutterTts.speak(speaking.answer);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
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
        title: Text(speaking.title.replaceAll("_n", "\n"),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(18),
            )),
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
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
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
                            topLeft: Radius.circular(
                          ScreenUtil().setWidth(75),
                        )),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                              top: ScreenUtil().setHeight(40),
                            ),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(14)),
                                child: Text(
                                  'Things to speak',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(20),
                                      color: Color(0xFF21BFBD)),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(10)),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                    ScreenUtil().setHeight(20),
                                  )),
                                  elevation: 5,
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(10),
                                        right: ScreenUtil().setWidth(45),
                                        top: ScreenUtil().setHeight(10),
                                      ),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            speaking.thingsToSpeak.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          resultant =
                                              speaking.thingsToSpeak[index];

                                          return ListTile(
                                            leading: Container(
                                                height:
                                                    ScreenUtil().setHeight(20),
                                                width:
                                                    ScreenUtil().setWidth(10),
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  shape: BoxShape.circle,
                                                )),
                                            title: Text(
                                              resultant.replaceAll('_n', '\n'),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(14),
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          );
                                        },
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  ScreenUtil().setHeight(8),
                                ),
                                child: Text(
                                  'Listen to sample answer',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(20),
                                      color: Color(0xFF21BFBD)),
                                ),
                              ),
                              _btnSection(),
                              SizedBox(
                                height: ScreenUtil().setHeight(15),
                              ),
                              Visibility(
                                visible: premium_user != true,
                                child: AdmobBanner(
                                    adUnitId: ams.getBannerAdId(),
                                    adSize: AdmobBannerSize.LARGE_BANNER),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  ScreenUtil().setHeight(8),
                                ),
                                child: Text(
                                  'Sample answer',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(20),
                                      color: Color(0xFF21BFBD)),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  ScreenUtil().setHeight(10),
                                ),
                                child: Text(
                                  speaking.answer.replaceAll("_n", "\n"),
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(14),
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  ScreenUtil().setHeight(8),
                                ),
                                child: FittedBox(
                                  child: Text(
                                    'Important Keywords for vocabulary',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(20),
                                        color: Color(0xFF21BFBD)),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(10),
                                    right: ScreenUtil().setWidth(10),
                                    top: ScreenUtil().setHeight(10),
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: speaking.vocabulary.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      vocabResult = speaking.vocabulary[index];
                                      return ListTile(
                                        leading: Container(
                                            height: ScreenUtil().setHeight(20),
                                            width: ScreenUtil().setWidth(10),
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).accentColor,
                                              shape: BoxShape.circle,
                                            )),
                                        title: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            vocabResult.replaceAll("_n", "\n"),
                                            style: TextStyle(
                                              fontSize: ScreenUtil().setSp(14),
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w400,
                                            ),
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

  Widget _btnSection() => Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _buildButtonColumn(
            Colors.green, Colors.white, Icons.play_arrow, 'PLAY', _speak),
        _buildButtonColumn(
            Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop)
      ]));

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              iconSize: ScreenUtil().setHeight(40),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
              child: Text(label,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).accentColor)))
        ]);
  }
}
