import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/utils/app_constants.dart';
import 'package:ielts/lesson_data/blog_data.dart';
import 'package:ielts/models/blog.dart';
import 'package:ielts/screens/blog_detail_screen.dart';
import 'package:ielts/viewModels/blogCrudModel.dart';
import 'package:ielts/widgets/circular_image.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BlogScreen extends StatefulWidget {
  BlogScreen({Key key}) : super(key: key);
  final Color backgroundColor = Color(0xFF21BFBD);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List blog;

  @override
  void initState() {
    super.initState();
    blog = getBlogData();
  }

  double screenHeight;
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    final productProvider = Provider.of<BlogCrudModel>(context);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      appBar: AppBar(
        title: Text(
          'Blog',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.2,
              fontSize: ScreenUtil().setSp(20),
              fontFamily: 'Montserrat'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, RoutePaths.home);
          },
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(14)),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Featured',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        color: Theme.of(context).accentColor,
                        fontSize: ScreenUtil().setSp(20),
                        fontFamily: 'Montserrat'),
                  )),
            ),
            Container(
              height: ScreenUtil().setHeight(310),
              width: ScreenUtil().setWidth(400),
              child: StreamBuilder(
                  stream: productProvider.fetchBlogsAsStream(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      blog = snapshot.data.documents
                          .map((doc) => Blog.fromMap(doc.data, doc.documentID))
                          .toList();
                      return ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return makeCard(blog[index]);
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(18),
                      top: ScreenUtil().setHeight(10),
                      bottom: ScreenUtil().setHeight(10)),
                  child: Text(
                    'Popular',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                        color: Theme.of(context).accentColor,
                        fontSize: ScreenUtil().setSp(20),
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
            Container(
              height: screenHeight,
              width: screenWidth,
              child: StreamBuilder(
                  stream: productProvider.fetchBlogsAsStream(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      blog = snapshot.data.documents
                          .map((doc) => Blog.fromMap(doc.data, doc.documentID))
                          .toList();
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: blog.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return bottomCard(blog[index]);
                        },
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget makeCard(Blog blog) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlogDetailScreen(blog: blog)));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: ScreenUtil().setHeight(310),
        width: ScreenUtil().setWidth(360),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20))),
            child: Stack(children: <Widget>[
              Hero(
                tag: blog.title,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ScreenUtil().setWidth(10)),
                      topRight: Radius.circular(ScreenUtil().setWidth(10))),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: ScreenUtil().setHeight(180),
                    width: ScreenUtil().setWidth(360),
                    imageUrl: blog.imageUrl,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(ScreenUtil().setHeight(12)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                          child: CircularImage(CachedNetworkImageProvider(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQQCcQzNKw6r9VqXtdJgwcXG6VcQxc9wMA6q0lMKaaTs5Ebj6fI&usqp=CAU')),
                        ),
                        Flexible(
                          child: Text(
                            blog.title,
                            maxLines: 3,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ])),
      ),
    );
  }

  Widget bottomCard(Blog blog) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlogDetailScreen(blog: blog)));
      },
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(
              ScreenUtil().setWidth(14),
            ),
            child: Hero(
              tag: blog.imageUrl,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(
                  ScreenUtil().setWidth(10),
                )),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: ScreenUtil().setHeight(60),
                  width: ScreenUtil().setWidth(60),
                  imageUrl: blog.imageUrl,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  blog.tags,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: ScreenUtil().setSp(12),
                  ),
                ),
                Text(
                  blog.title.replaceAll('_n', '/n'),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
                Text(
                  DateFormat('dd MMM yyyy').format(blog.time),
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: ScreenUtil().setSp(12),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
