import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fader/flutter_fader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:ielts/utils/app_constants.dart';
import 'package:ielts/lesson_data/vocabulary_data.dart';
import 'package:ielts/models/vocabulary.dart';

final Color backgroundColor = Color(0xFF21BFBD);

class VocabularyScreen extends StatefulWidget {
  VocabularyScreen({Key key}) : super(key: key);

  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen>
    with SingleTickerProviderStateMixin {
  List vocabulary;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();

    vocabulary = getVocabularyData();
    vocabulary.shuffle();
  }

  FaderController faderController = FaderController();

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
      body: Stack(
        children: <Widget>[
          dashboard(context),
        ],
      ),
    );
  }

  Widget dashboard(context) {
    CardController controller;
    return Material(
      animationDuration: duration,
      borderRadius:
          BorderRadius.all(Radius.circular(ScreenUtil().setWidth(40))),
      elevation: 8,
      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(48)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(18)),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RoutePaths.home);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(18)),
                    child: Icon(Icons.settings, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(25)),
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
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  primary: false,
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(25),
                      right: ScreenUtil().setWidth(20)),
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(570),
                      child: Container(
                        child: TinderSwapCard(
                            orientation: AmassOrientation.BOTTOM,
                            totalNum: vocabulary.length,
                            stackNum: 3,
                            swipeEdge: 4.0,
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
                        width: ScreenUtil().setWidth(20),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/swipe.png"),
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
    return Card(
      elevation: 8.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                child: Text(
                  'Word :    ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(20),
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                child: Text(
                  StringUtils.capitalize(vocabulary.word ?? 'Word'),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: ScreenUtil().setSp(18),
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(15)),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
            child: Row(
              children: <Widget>[
                Text(
                  'Description : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil().setSp(20),
                    fontFamily: 'Montserrat',
                  ),
                ),
                Flexible(
                  child: Column(
                    children: <Widget>[
                      Text(
                        vocabulary.description ?? 'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(16),
                            fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(25)),
          Row(
            children: <Widget>[
              Text(
                'Sentence : ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(20),
                  fontFamily: 'Montserrat',
                ),
              ),
              Flexible(
                child: Column(
                  children: <Widget>[
                    Text(
                      vocabulary.sentence ?? 'sentence',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontFamily: 'Montserrat'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
