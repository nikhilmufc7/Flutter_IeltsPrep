import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
                      height: 400.0,
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
                    padding: EdgeInsets.only(left: 30.0),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Colors.black,
                  ),
                ],
              ),
              Positioned.fill(
                bottom: 10.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(10.0),
                    elevation: 12.0,
                    onPressed: () => print('Play Video'),
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.play_arrow,
                      size: 60.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0.0,
                  left: 20.0,
                  child: Text(
                    blog.tags,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                    ),
                  )),
              Positioned(
                  bottom: 0.0,
                  right: 25.0,
                  child: Text(
                    DateFormat('dd MMM yyyy').format(blog.time),
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              blog.title.replaceAll("_n", "\n"),
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                fontStyle: FontStyle.italic,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              blog.content.replaceAll("_n", "\n"),
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
