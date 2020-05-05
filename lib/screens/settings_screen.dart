import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ielts/services/auth.dart';

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

  bool _subscribleToEmails = false;

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
        title: Text("Settings"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.wb_sunny),
            title: Text('Dark Theme'),
            contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
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
            title: Text('Subscribe to emails'),
            subtitle:
                Text('Get the latest news about IELTS directly to your mail'),
            contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
            trailing: Transform.scale(
              scale: 0.4,
              child: DayNightSwitch(
                value: _subscribleToEmails,
                onChanged: (val) {
                  setState(() {
                    _subscribleToEmails = val;
                  });
                },
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
            contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
            trailing: Padding(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(18)),
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
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                signOutGoogle(context);
              },
              color: Colors.deepPurpleAccent,
              child: Text('Sign Out', style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
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
