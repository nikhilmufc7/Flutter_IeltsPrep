import 'package:custom_switch/custom_switch.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/services/auth.dart';
import 'package:ielts/utils/app_constants.dart';

import 'package:ielts/utils/themeChange.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ielts/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _darkTheme = false;

  _launchURL() async {
    const url =
        'https://docs.google.com/forms/d/e/1FAIpQLSdh42EeLl4mm69AHo5NgdUPiikTShtp9QqpJKoYH1M2SNo1yg/viewform';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchContactUrl() async {
    const url = 'mailto:singh.nikhil999@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(RoutePaths.home);
            }),
        title: Text(
          "Settings",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(18)),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text('Dark Theme'),
                contentPadding:
                    EdgeInsets.only(left: ScreenUtil().setWidth(16)),
                trailing: Transform.scale(
                  scale: 0.4,
                  child: DayNightSwitch(
                    value: _darkTheme,
                    onChanged: (val) {
                      setState(() {
                        _darkTheme = val;
                      });
                      onThemeChanged(val, themeNotifier);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('Contact us'),
                subtitle:
                    Text('Feel free to contact us for any enquiries or help'),
                contentPadding:
                    EdgeInsets.only(left: ScreenUtil().setWidth(16)),
                trailing: Padding(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(14)),
                  child: Transform.scale(
                    scale: 0.8,
                    child: RaisedButton(
                      elevation: 8,
                      color: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        'Mail',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _launchContactUrl,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Provide Feedback'),
                subtitle: Text('Helps us be better'),
                contentPadding:
                    EdgeInsets.only(left: ScreenUtil().setWidth(16)),
                trailing: Padding(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(14)),
                  child: Transform.scale(
                    scale: 0.8,
                    child: RaisedButton(
                      elevation: 8,
                      color: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        'Go',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _launchURL,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About us'),
                subtitle:
                    Text('View our privacy policy and terms and conditions'),
                contentPadding:
                    EdgeInsets.only(left: ScreenUtil().setWidth(16)),
                trailing: Padding(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(14)),
                  child: Transform.scale(
                    scale: 0.8,
                    child: RaisedButton(
                      elevation: 8,
                      color: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        'View',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RoutePaths.credits);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(50)),
              child: FlatButton(
                onPressed: () {
                  signOutGoogle(context);
                },
                child: Container(
                  height: ScreenUtil().setHeight(50),
                  width: ScreenUtil().setWidth(200),
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(15)),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.deepPurpleAccent),
                  child: FittedBox(
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(20),
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
