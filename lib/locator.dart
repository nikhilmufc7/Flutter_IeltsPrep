import 'package:get_it/get_it.dart';
import 'package:ielts/services/api.dart';
import 'package:ielts/services/blogApi.dart';
import 'package:ielts/services/listeningApi.dart';
import 'package:ielts/services/quizApi.dart';
import 'package:ielts/services/readingApi.dart';
import 'package:ielts/services/speakingApi.dart';
import 'package:ielts/viewModels/blogCrudModel.dart';

import 'package:ielts/viewModels/listeningCrudModel.dart';
import 'package:ielts/viewModels/quizCrudModel.dart';
import 'package:ielts/viewModels/readingCrudModel.dart';
import 'package:ielts/viewModels/speakingCrudModel.dart';

import 'package:ielts/viewModels/writingCrudModel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api('writing'));
  locator.registerLazySingleton(() => SpeakingApi('speaking'));
  locator.registerLazySingleton(() => CrudModel());
  locator.registerLazySingleton(() => SpeakingCrudModel());
  locator.registerLazySingleton(() => ReadingApi('reading'));
  locator.registerLazySingleton(() => ReadingCrudModel());
  locator.registerLazySingleton(() => ListeningApi('listening'));
  locator.registerLazySingleton(() => ListeningCrudModel());
  locator.registerLazySingleton(() => BlogApi('blogs'));
  locator.registerLazySingleton(() => BlogCrudModel());
  locator.registerLazySingleton(() => QuizApi('quiz'));
  locator.registerLazySingleton(() => QuizCrudModel());
}
