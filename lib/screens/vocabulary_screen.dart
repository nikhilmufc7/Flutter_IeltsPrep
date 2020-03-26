import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:ielts/lesson_data/vocabulary_data.dart';
import 'package:ielts/models/vocabulary.dart';
import 'package:ielts/widgets/menu_page.dart';

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
      body: Stack(
        children: <Widget>[
          MenuPage(),
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
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
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
                        child: InkWell(
                          child: Icon(Icons.menu, color: Colors.white),
                          onTap: () {
                            setState(() {
                              if (isCollapsed)
                                _controller.forward();
                              else
                                _controller.reverse();

                              isCollapsed = !isCollapsed;
                            });
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
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(75.0)),
                    ),
                    child: ListView(
                      primary: false,
                      padding: EdgeInsets.only(left: 25.0, right: 20.0),
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height - 300.0,
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
                                    //Card is LEFT swiping
                                  } else if (align.x > 0) {
                                    //Card is RIGHT swiping
                                  }
                                },
                                swipeCompleteCallback:
                                    (CardSwipeOrientation orientation,
                                        int index) {
                                  /// Get orientation & index of swiped card!
                                }),
                          ),
                        ),
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
      child: Column(
        children: <Widget>[
          Text(vocabulary.word),
          Text(vocabulary.description),
          Text(vocabulary.sentence)
        ],
      ),
    );
  }
}
