import 'package:flutter/material.dart';

import 'package:ielts/app_constants.dart';
import 'package:ielts/locator.dart';
import 'package:ielts/router.dart';

import 'package:ielts/viewModels/listeningCrudModel.dart';
import 'package:ielts/viewModels/readingCrudModel.dart';
import 'package:ielts/viewModels/speakingCrudModel.dart';

import 'package:ielts/viewModels/writingCrudModel.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => locator<CrudModel>()),
          ChangeNotifierProvider(create: (_) => locator<SpeakingCrudModel>()),
          ChangeNotifierProvider(create: (_) => locator<ReadingCrudModel>()),
          ChangeNotifierProvider(create: (_) => locator<ListeningCrudModel>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Montserrat'),
          title: 'IELTS',
          initialRoute: RoutePaths.root,
          onGenerateRoute: Router.generateRoute,
        ));
  }
}
