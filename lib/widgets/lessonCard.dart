import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  final String title;
  final double indicatorValue;
  final String level;
  final Widget trailing;
  final Function onTap;

  LessonCard(
      {Key key,
      this.title,
      this.indicatorValue,
      this.level,
      this.onTap,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, left: 5, right: 5),
      child: Card(
        color: Color.fromRGBO(64, 75, 96, .9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1.0, color: Colors.white24))),
              child: Icon(Icons.autorenew, color: Colors.white),
            ),
            title: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      // tag: 'hero',
                      child: LinearProgressIndicator(
                          backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                          value: indicatorValue,
                          valueColor: AlwaysStoppedAnimation(Colors.green)),
                    )),
                Expanded(
                  flex: 4,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child:
                          Text(level, style: TextStyle(color: Colors.white))),
                )
              ],
            ),
            trailing: trailing,
            onTap: onTap),
      ),
    );
  }
}
