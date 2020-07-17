import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/utils/constants.dart';

class TextColumn extends StatelessWidget {
  final String title;
  final String text;

  const TextColumn({
    @required this.title,
    @required this.text,
  })  : assert(title != null),
        assert(text != null);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    return Column(
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.headline5.copyWith(
              color: kWhite,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(18)),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: kSpaceS),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: kWhite, fontSize: ScreenUtil().setSp(15)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
