import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ielts/app_constants.dart';
import 'package:ielts/models/userModel.dart';
import 'package:ielts/services/auth.dart';
import 'package:ielts/viewModels/speakingCrudModel.dart';

import 'package:ielts/widgets/circular_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  final List<MenuItem> options = [
    MenuItem(Icons.home, 'Home', RoutePaths.root),
    MenuItem(Icons.library_books, 'Vocabulary', RoutePaths.vocabulary),
    MenuItem(Icons.speaker_notes, 'Blog', RoutePaths.blog),
    MenuItem(Icons.people, 'Forum', ''),
    MenuItem(Icons.format_list_bulleted, 'Tips and tricks', ''),
  ];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<SpeakingCrudModel>(context);
    return GestureDetector(
      // onPanUpdate: (details) {
      //   //on swiping left
      //   if (details.delta.dx < -6) {
      //     Provider.of<MenuController>(context, listen: true).toggle();
      //   }
      // },
      child: Container(
        padding: EdgeInsets.only(
            top: 62,
            left: 32,
            bottom: 8,
            right: MediaQuery.of(context).size.width / 2.9),
        color: Color(0xff454dff),
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
                            NetworkImage(
                              user.photoUrl,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            user.firstName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
                              padding: const EdgeInsets.all(8.0),
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
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, item.routeName);
                  },
                  leading: Icon(
                    item.icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.settings,
                color: Colors.white,
                size: 20,
              ),
              title: Text('Settings',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.headset_mic,
                color: Colors.white,
                size: 20,
              ),
              title: Text('Support',
                  style: TextStyle(fontSize: 14, color: Colors.white)),
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
