import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'customClipper.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    return Container(
        child: Transform.rotate(
      angle: -pi / 3.5,
      child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: ScreenUtil().setHeight(280),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color(0xFF21BFBD)),
        ),
      ),
    ));
  }
}
