import 'package:admob_flutter/admob_flutter.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fader/flutter_fader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ielts/screens/home_screen.dart';
import 'package:ielts/services/admob_service.dart';

import 'package:ielts/utils/app_constants.dart';
import 'package:ielts/lesson_data/vocabulary_data.dart';
import 'package:ielts/models/vocabulary.dart';

final Color backgroundColor = Color(0xFF21BFBD);

class VocabularyScreen extends StatefulWidget {
  VocabularyScreen({Key key}) : super(key: key);

  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

enum TtsState { playing, stopped }

class _VocabularyScreenState extends State<VocabularyScreen>
    with SingleTickerProviderStateMixin {
  List vocabulary;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);

  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  FlutterTts flutterTts;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  final ams = AdMobService();

  @override
  void initState() {
    super.initState();

    vocabulary = getVocabularyData();
    vocabulary.shuffle();
    initTts();
  }

  FaderController faderController = FaderController();

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
    Admob.initialize(ams.getAdMobAppId());
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
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(RoutePaths.home);
            }),
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: <Widget>[
          dashboard(context),
          Visibility(
            visible: premium_user != true,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AdmobBanner(
                  adUnitId: ams.getBannerAdId(),
                  adSize: AdmobBannerSize.LARGE_BANNER),
            ),
          ),
        ],
      ),
    );
  }

  Widget dashboard(context) {
    CardController controller;
    return Material(
      animationDuration: duration,
      // borderRadius:
      //     BorderRadius.all(Radius.circular(ScreenUtil().setWidth(40))),
      elevation: 8,
      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(18)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                child: Row(
                  children: <Widget>[
                    Text('Vocabulary',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(25))),
                    SizedBox(width: ScreenUtil().setWidth(10)),
                    // Text('Prep',
                    //     style: TextStyle(
                    //         fontFamily: 'Montserrat',
                    //         color: Colors.white,
                    //         fontSize: ScreenUtil().setSp(25)))
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(40)),
              Container(
                height: MediaQuery.of(context).size.height,
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
                child: Column(
                  // physics: ClampingScrollPhysics(),
                  // primary: false,
                  // padding: EdgeInsets.only(
                  //     left: ScreenUtil().setWidth(25),
                  //     right: ScreenUtil().setWidth(20)),
                  children: <Widget>[
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                    Container(
                      height: screenHeight / 1.8,
                      child: Container(
                        child: TinderSwapCard(
                            orientation: AmassOrientation.BOTTOM,
                            totalNum: vocabulary.length,
                            stackNum: 4,
                            swipeEdge: 3.0,
                            maxWidth: MediaQuery.of(context).size.width * 0.9,
                            maxHeight: MediaQuery.of(context).size.width * 0.9,
                            minWidth: MediaQuery.of(context).size.width * 0.8,
                            minHeight: MediaQuery.of(context).size.width * 0.8,
                            cardBuilder: (context, index) =>
                                makeCard(vocabulary[index]),
                            cardController: controller = CardController(),
                            swipeUpdateCallback:
                                (DragUpdateDetails details, Alignment align) {
                              /// Get swiping card's alignment
                              if (align.x < 0) {
                                faderController.fadeOut();
                              } else if (align.x > 0) {
                                faderController.fadeOut();
                              }
                            },
                            swipeCompleteCallback:
                                (CardSwipeOrientation orientation, int index) {
                              /// Get orientation & index of swiped card!
                            }),
                      ),
                    ),
                    Fader(
                      controller: faderController,
                      duration: const Duration(milliseconds: 5),
                      child: Container(
                        height: ScreenUtil().setHeight(60),
                        width: ScreenUtil().setWidth(40),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/swipe.jpeg"),
                            fit: BoxFit.fitHeight,
                          ),
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setWidth(12)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget makeCard(Vocabulary vocabulary) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8.0,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            ListTile(
              title: Text(
                StringUtils.capitalize(vocabulary.word ?? 'Word'),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: ScreenUtil().setSp(24),
                  fontFamily: 'Montserrat',
                ),
              ),
              trailing: _btnSection(vocabulary),
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            ListTile(
              title: Text(
                vocabulary.description ?? 'Description',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(16),
                    fontFamily: 'Montserrat'),
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            ListTile(
              title: Text(
                'Usage in Sentence',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(16),
                    fontFamily: 'Montserrat'),
              ),
            ),
            ListTile(
              title: Text(
                vocabulary.sentence ?? 'sentence',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(14),
                    fontFamily: 'Montserrat'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btnSection(Vocabulary vocabulary) => Container(
          child: _buildButtonColumn(
              Colors.green, Colors.white, Icons.volume_up, 'PLAY', () async {
        await flutterTts.setVolume(volume);
        await flutterTts.setSpeechRate(rate);
        await flutterTts.setPitch(pitch);

        if (vocabulary.word != null) {
          if (vocabulary.word.isNotEmpty) {
            var result = await flutterTts.speak(vocabulary.word);
            if (result == 1) setState(() => ttsState = TtsState.playing);
          }
        }
      }));

  IconButton _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return IconButton(
        icon: Icon(icon),
        iconSize: ScreenUtil().setHeight(40),
        color: color,
        splashColor: splashColor,
        onPressed: () => func());
  }
}
