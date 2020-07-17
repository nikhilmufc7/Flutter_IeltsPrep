import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ielts/screens/home_screen.dart';

class PremiumScreen extends StatefulWidget {
  @override
  _PremiumScreenState createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  bool _premiumUser = false;
  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  StreamSubscription _conectionSubscription;
  final List<String> _productLists = Platform.isAndroid
      ? [
          'vault_premium',
        ]
      : ['com.cooni.point1000', 'com.cooni.point5000'];

  String _platformVersion = 'Unknown';
  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
    this._getProduct();
  }

  @override
  void dispose() {
    if (_conectionSubscription != null) {
      _conectionSubscription.cancel();
      _conectionSubscription = null;
    }
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.

    final user = await FirebaseAuth.instance.currentUser();

    try {
      platformVersion = await FlutterInappPurchase.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // prepare
    var result = await FlutterInappPurchase.instance.initConnection;
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAllItems;
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) async {
      await Firestore.instance
          .collection('premium_users')
          .document(user.uid)
          .setData({
        "premium_user": true,
        "transactionDate": productItem.transactionDate,
        "transactionId": productItem.transactionId,
        "purchaseToken": productItem.purchaseToken,
        "orderId": productItem.orderId,
        "transactionReceipt": productItem.transactionReceipt,
        "productId": productItem.productId,
        "userId": user.uid,
        "userEmail": user.email,
        "userName": user.displayName
      });

      setState(() {
        _premiumUser = true;
        premium_user = true;
      });

      await FlutterInappPurchase.instance.finishTransaction(
        productItem,
        developerPayloadAndroid: productItem.developerPayloadAndroid,
        isConsumable: false,
      );

      await FlutterInappPurchase.instance
          .acknowledgePurchaseAndroid(productItem.purchaseToken);

      Navigator.pop(context);
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });
  }

  void _requestPurchase(IAPItem item) async {
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  Future _getProduct() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in items) {
      print('${item.toString()}');
      this._items.add(item);
    }

    setState(() {
      this._items = items;
      this._purchases = [];
    });
  }

  Future _getPurchases() async {
    List<PurchasedItem> items =
        await FlutterInappPurchase.instance.getAvailablePurchases();
    for (var item in items) {
      print('${item.toString()}');
      this._purchases.add(item);
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }

  Future _getPurchaseHistory() async {
    List<PurchasedItem> items =
        await FlutterInappPurchase.instance.getPurchaseHistory();
    for (var item in items) {
      print('${item.toString()}');
      this._purchases.add(item);
    }

    setState(() {
      this._items = [];
      this._purchases = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenUtil.init(context, width: 414, height: 896);

//If you want to set the font size is scaled according to the system's "font size" assist option
    ScreenUtil.init(context, width: 414, height: 896, allowFontScaling: true);
    double screenWidth = MediaQuery.of(context).size.width - 20;
    double buttonWidth = (screenWidth / 3) - 20;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
            //     Column(
            //       children: this._renderInApps(),
            //     ),
            //   ],
            // ),
            IconButton(
              alignment: Alignment.topLeft,
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () => Navigator.pop(context),
            ),
            Image(
              image: AssetImage(
                "assets/premium.jpg",
              ),
              height: ScreenUtil().setHeight(200),
              width: double.infinity,
            ),
            Text(
              'Vault Premium',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(20)),
            ),
            ListTile(
              leading: Icon(
                Icons.verified_user,
                color: Colors.deepPurpleAccent,
              ),
              title: Text(
                'No Ads',
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                'Concentrate just on studying!',
                style: TextStyle(
                    color: Colors.black87, fontSize: ScreenUtil().setSp(14)),
              ),
            ),

            ListTile(
              leading: Icon(
                Icons.verified_user,
                color: Colors.deepPurpleAccent,
              ),
              title: Text(
                'Unlock discussion forums',
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                'Ask questions, get help, essay reviews',
                style: TextStyle(
                    color: Colors.black87, fontSize: ScreenUtil().setSp(14)),
              ),
            ),

            ListTile(
              leading: Icon(
                Icons.verified_user,
                color: Colors.deepPurpleAccent,
              ),
              title: Text(
                'Support Development',
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                'Your help keeps us working on this project further',
                style: TextStyle(
                    color: Colors.black87, fontSize: ScreenUtil().setSp(14)),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: this._button(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _button() {
    List<Widget> widgets = this
        ._items
        .map((item) => Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
                        child: FlatButton(
                          onPressed: () {
                            this._requestPurchase(item);
                          },
                          child: Container(
                            height: ScreenUtil().setHeight(50),
                            width: ScreenUtil().setWidth(300),
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(15)),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.deepPurpleAccent),
                            child: FittedBox(
                              child: Text(
                                'Get for ${item.currency + item.localizedPrice}',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(20),
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        .toList();
    return widgets;
  }
}
