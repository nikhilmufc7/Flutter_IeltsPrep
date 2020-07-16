import 'package:admob_flutter/admob_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/models/lesson.dart';
import 'package:ielts/screens/home_screen.dart';
import 'package:ielts/services/admob_service.dart';

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
  final ams = AdMobService();

  @override
  void initState() {
    super.initState();
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
      backgroundColor: Theme.of(context).bottomAppBarColor,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(lesson.title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setSp(18))),
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
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Card(
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
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: CachedNetworkImage(
                                imageUrl: lesson.image,
                                placeholder: (context, url) => SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: Image.asset('assets/transparent.gif'),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: premium_user == true,
                            child: AdmobBanner(
                                adUnitId: ams.getBannerAdId(),
                                adSize: AdmobBannerSize.LARGE_BANNER),
                          ),
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
                          ),
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
