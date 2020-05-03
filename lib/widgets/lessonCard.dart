import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    return Padding(
      padding: EdgeInsets.only(
          bottom: ScreenUtil().setHeight(15),
          left: ScreenUtil().setWidth(5),
          right: ScreenUtil().setWidth(5)),
      child: Card(
        color: Color.fromRGBO(64, 75, 96, .9),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(15))),
        elevation: 8.0,
        margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
            vertical: ScreenUtil().setHeight(6)),
        child: ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(20),
                vertical: ScreenUtil().setHeight(10)),
            leading: Container(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1.0, color: Colors.white24))),
              child: Icon(Icons.autorenew, color: Colors.white),
            ),
            title: Text(
              title,
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: ScreenUtil().setSp(16),
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
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
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
