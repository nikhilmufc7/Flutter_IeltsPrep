import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fader/flutter_fader.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:ielts/app_constants.dart';
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
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);

    vocabulary = getVocabularyData();
    vocabulary.shuffle();
  }

  FaderController faderController = FaderController();

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
      body: Stack(
        children: <Widget>[
          dashboard(context),
        ],
      ),
    );
  }

  Widget dashboard(context) {
    CardController controller;
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: Theme.of(context).primaryColor,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RoutePaths.home);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Icon(Icons.settings, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text('Vocabulary',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0)),
                        SizedBox(width: 10.0),
                        // Text('Prep',
                        //     style: TextStyle(
                        //         fontFamily: 'Montserrat',
                        //         color: Colors.white,
                        //         fontSize: 25.0))
                      ],
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    height: MediaQuery.of(context).size.height,
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
                      physics: ClampingScrollPhysics(),
                      primary: false,
                      padding: EdgeInsets.only(left: 25.0, right: 20.0),
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height - 400.0,
                          child: Container(
                            child: TinderSwapCard(
                                orientation: AmassOrientation.BOTTOM,
                                totalNum: vocabulary.length,
                                stackNum: 3,
                                swipeEdge: 4.0,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                                maxHeight:
                                    MediaQuery.of(context).size.width * 0.9,
                                minWidth:
                                    MediaQuery.of(context).size.width * 0.8,
                                minHeight:
                                    MediaQuery.of(context).size.width * 0.8,
                                cardBuilder: (context, index) =>
                                    makeCard(vocabulary[index]),
                                cardController: controller = CardController(),
                                swipeUpdateCallback: (DragUpdateDetails details,
                                    Alignment align) {
                                  /// Get swiping card's alignment
                                  if (align.x < 0) {
                                    faderController.fadeOut();
                                  } else if (align.x > 0) {
                                    faderController.fadeOut();
                                  }
                                },
                                swipeCompleteCallback:
                                    (CardSwipeOrientation orientation,
                                        int index) {
                                  /// Get orientation & index of swiped card!
                                }),
                          ),
                        ),
                        Fader(
                          controller: faderController,
                          duration: const Duration(milliseconds: 5),
                          child: Container(
                            height: 60,
                            width: 20,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/swipe.png"),
                                fit: BoxFit.fitHeight,
                              ),
                              borderRadius: BorderRadius.circular(12),
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
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Word :    ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  StringUtils.capitalize(vocabulary.word ?? 'Word'),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Description : ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
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
                            fontSize: 16,
                            fontFamily: 'Montserrat'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 25),
          Row(
            children: <Widget>[
              Text(
                'Sentence : ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
                          fontSize: 16,
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
