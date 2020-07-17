import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/screens/onboarding/widgets/cards_stack.dart';
import 'package:ielts/utils/constants.dart';

class OnboardingPage extends StatelessWidget {
  final int number;
  final Widget lightCardChild;
  final Widget darkCardChild;
  final Animation<Offset> lightCardOffsetAnimation;
  final Animation<Offset> darkCardOffsetAnimation;
  final Widget textColumn;

  const OnboardingPage({
    @required this.number,
    @required this.lightCardChild,
    @required this.darkCardChild,
    @required this.lightCardOffsetAnimation,
    @required this.darkCardOffsetAnimation,
    @required this.textColumn,
  })  : assert(number != null),
        assert(lightCardChild != null),
        assert(darkCardChild != null),
        assert(lightCardOffsetAnimation != null),
        assert(darkCardOffsetAnimation != null),
        assert(textColumn != null);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    return Column(
      children: <Widget>[
        CardsStack(
          pageNumber: number,
          lightCardChild: lightCardChild,
          darkCardChild: darkCardChild,
          lightCardOffsetAnimation: lightCardOffsetAnimation,
          darkCardOffsetAnimation: darkCardOffsetAnimation,
        ),
        SizedBox(
          height: number % 2 == 1
              ? ScreenUtil().setHeight(50)
              : ScreenUtil().setHeight(25),
        ),
        AnimatedSwitcher(
          duration: kCardAnimationDuration,
          child: textColumn,
        ),
        SizedBox(
          height: number % 2 == 1
              ? ScreenUtil().setHeight(50)
              : ScreenUtil().setHeight(50),
        ),
        Visibility(
            visible: number == 3,
            child: FittedBox(
              child: Text(
                'Get Premium now and kickstart your journey!',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(14)),
              ),
            ))
      ],
    );
  }
}
