import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/utils/constants.dart';

class WorkDarkCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.person_pin,
              color: kWhite,
              size: 32.0,
            ),
          ],
        ),
        const SizedBox(height: kSpaceM),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.person,
              color: kWhite,
              size: ScreenUtil().setSp(32),
            ),
            Icon(
              Icons.group,
              color: kWhite,
              size: ScreenUtil().setSp(32),
            ),
            Icon(
              Icons.insert_emoticon,
              color: kWhite,
              size: ScreenUtil().setSp(32),
            ),
          ],
        ),
      ],
    );
  }
}
