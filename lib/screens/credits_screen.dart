import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _launchPrivacyPolicty() async {
      const url = 'https://ieltsvault.tech/privacy.html';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    _launchTermsAndConditions() async {
      const url = 'https://ieltsvault.tech/terms.html';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Credits",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil().setSp(18)),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          padding: EdgeInsets.only(bottom: 10),
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('IELTS',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(22))),
                SizedBox(width: ScreenUtil().setWidth(10)),
                Text('Vault',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontStyle: FontStyle.italic,
                        fontSize: ScreenUtil().setSp(22)))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Prepare for the Ielts exam with Ielts Vault and open the door of opportunities! Free and without ads, now and always!',
                style: TextStyle(
                    fontSize: ScreenUtil().setWidth(16),
                    fontFamily: 'Montserrat'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
                  child: FittedBox(
                    child: Text('Team',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(22))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              title: Text('Nikhil Singh',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(22))),
              subtitle: Text('Developer',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: ScreenUtil().setSp(16))),
              trailing: Icon(Icons.computer),
            ),
            SizedBox(width: ScreenUtil().setWidth(10)),
            ListTile(
              title: Text('Mrudula Vable',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(22))),
              subtitle: Text('Lead content strategist',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: ScreenUtil().setSp(16))),
              trailing: Icon(Icons.content_paste),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
                  child: FittedBox(
                    child: Text('Content sources',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(22))),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
              child: Text(
                'Content has been sourced from various open source media available in the public domain. For removal of any content please drop us an email at singh.nikhil999@gmail.com',
                style: TextStyle(
                    fontFamily: 'Montserrat', fontSize: ScreenUtil().setSp(14)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.deepPurple,
                  onPressed: () => _launchPrivacyPolicty(),
                  child: FittedBox(
                    child: Text(
                      'Privacy policy',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.white),
                    ),
                  ),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.deepPurple,
                  onPressed: () => _launchTermsAndConditions(),
                  child: FittedBox(
                    child: Text(
                      'Terms and conditions',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
