import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/models/blog.dart';
import 'package:ielts/widgets/circular_clipper.dart';
import 'package:intl/intl.dart';

class BlogDetailScreen extends StatefulWidget {
  final Blog blog;
  BlogDetailScreen({
    Key key,
    this.blog,
  }) : super(key: key);

  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState(blog);
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  final Blog blog;
  _BlogDetailScreenState(this.blog);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Hero(
                  tag: blog.imageUrl,
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: Image(
                      height: ScreenUtil().setHeight(400),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(blog.imageUrl),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    iconSize: ScreenUtil().setSp(30),
                    color: Colors.black,
                  ),
                ],
              ),
              Positioned.fill(
                bottom: ScreenUtil().setHeight(10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                    elevation: 12.0,
                    onPressed: () => print('Play Video'),
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.play_arrow,
                      size: ScreenUtil().setWidth(60),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0.0,
                  left: ScreenUtil().setWidth(20),
                  child: Text(
                    blog.tags,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  )),
              Positioned(
                  bottom: 0.0,
                  right: ScreenUtil().setWidth(25),
                  child: Text(
                    DateFormat('dd MMM yyyy').format(blog.time),
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Montserrat',
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
            child: Text(
              blog.title.replaceAll("_n", "\n"),
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.italic,
                fontSize: ScreenUtil().setSp(20),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
            child: Text(
              blog.content.replaceAll("_n", "\n"),
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
                fontSize: ScreenUtil().setSp(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
