import 'package:get_it/get_it.dart';

import '../services/localstorage.dart';
import '../services/test.dart';

final GetIt locator = GetIt.instance;

void setupLocator() async {

  locator.registerSingleton(Test());
  //locator.registerFactory<StorageService>(() => StorageService());
}