import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/models/lesson.dart';

final Color backgroundColor = Color(0xFF21BFBD);

class WritingDetailScreen extends StatefulWidget {
  final Lesson lesson;
  WritingDetailScreen({
    Key key,
    this.lesson,
  }) : super(key: key);

  @override
  _WritingDetailScreenState createState() => _WritingDetailScreenState(lesson);
}

class _WritingDetailScreenState extends State<WritingDetailScreen>
    with SingleTickerProviderStateMixin {
  final Lesson lesson;
  _WritingDetailScreenState(this.lesson);

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
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        bottomOpacity: 0.0,
      ),
      body: Material(
        animationDuration: duration,
        // borderRadius: BorderRadius.all(Radius.circular(40)),
        elevation: 8,
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setHeight(ScreenUtil().setHeight(10))),
                  child: FittedBox(
                    child: Text(lesson.title,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(25))),
                  ),

                  // Text('Prep',
                  //     style: TextStyle(
                  //         fontFamily: 'Montserrat',
                  //         color: Colors.white,
                  //         fontSize: 25.0))
                ),
                SizedBox(height: ScreenUtil().setHeight(40)),
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
                          topLeft: Radius.circular(ScreenUtil().setWidth(75))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(
                            top: ScreenUtil()
                                .setHeight(ScreenUtil().setHeight(40))),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 8,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Question',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: ScreenUtil().setSp(20),
                                        color: Color(0xFF21BFBD)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(
                                      ScreenUtil().setHeight(10)),
                                  child: Text(
                                    lesson.question.replaceAll("_n", "\n"),
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(16),
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(25)),
                          Card(
                            elevation: 8,
                            child: CachedNetworkImage(
                              imageUrl: lesson.image,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          SizedBox(height: ScreenUtil().setHeight(20)),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                onPressed: () {
                                  openBookingDetailsSheet(context, lesson);
                                },
                                child: Text('Sample Answer',
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(20),
                                      fontFamily: 'Montserrat',
                                    )),
                                color: Colors.deepPurpleAccent,
                                textColor: Colors.white,
                                elevation: 5,
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openBookingDetailsSheet(BuildContext context, Lesson lesson) {
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
              child: Text(
                lesson.answer.replaceAll("_n", "\n"),
                style: TextStyle(
                  letterSpacing: 1.4,
                  height: 1.5,
                  fontFamily: 'Montserrat',
                  fontSize: ScreenUtil().setSp(16),
                ),
              )),
        ],
      ),
    );
  }

  // Widget dashboard(context) {
  //   CardController controller;
  //   return
  // }

}
