import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ielts/utils/app_constants.dart';
import 'package:ielts/models/userModel.dart';
import 'package:ielts/services/auth.dart';

import 'package:ielts/widgets/circular_image.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuPage extends StatelessWidget {
  _launchURL() async {
    const url = 'mailto:singh.nikhil999@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final List<MenuItem> options = [
    MenuItem(Icons.home, 'Home', RoutePaths.root),
    MenuItem(Icons.library_books, 'Vocabulary', RoutePaths.vocabulary),
    MenuItem(Icons.speaker_notes, 'Blog', RoutePaths.blog),
    MenuItem(Icons.people, 'Quiz', RoutePaths.quiz),
    MenuItem(Icons.forum, 'Discussions', RoutePaths.forum),
    MenuItem(Icons.forum, 'Premium', RoutePaths.premium),
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    return GestureDetector(
      onPanUpdate: (details) {
        //on swiping left
        // if (details.delta.dx < 6) {
        //   Provider.of<MenuController>(context, listen: true).toggle();
        // }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(62),
            left: ScreenUtil().setWidth(32),
            bottom: ScreenUtil().setHeight(8),
            right: MediaQuery.of(context).size.width / 2.9),
        child: Column(
          children: <Widget>[
            Flexible(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('users')
                      .document(userId)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      User user = User.from(snapshot.data);
                      return Row(
                        children: <Widget>[
                          CircularImage(
                            CachedNetworkImageProvider(user.photoUrl),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(15),
                          ),
                          Text(
                            user.firstName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(20),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.all(ScreenUtil().setHeight(8)),
                              child: Icon(Icons.warning),
                            ),
                            Text('Error in loading data')
                          ],
                        ),
                      );
                    }
                  }),
            ),
            Spacer(),
            Column(
              children: options.map((item) {
                return Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(3)),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, item.routeName);
                    },
                    leading: Icon(
                      item.icon,
                      color: Colors.white,
                      size: ScreenUtil().setSp(20),
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(14),
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(3)),
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, RoutePaths.settings);
                },
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: ScreenUtil().setSp(20),
                ),
                title: Text('Settings',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14), color: Colors.white)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(3)),
              child: ListTile(
                onTap: () => _launchURL(),
                leading: Icon(
                  Icons.headset_mic,
                  color: Colors.white,
                  size: ScreenUtil().setSp(20),
                ),
                title: Text('Contact us',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(14), color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  String title;
  IconData icon;
  String routeName;

  MenuItem(this.icon, this.title, this.routeName);
}
