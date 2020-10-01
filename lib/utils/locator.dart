import 'package:flutter_starter/services/api.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';

import '../services/storage_service.dart';
import '../services/api.dart';
import '../services/test.dart';

final GetIt locator = GetIt.instance;

void setupLocator() async {

  locator.registerSingleton<Test>(Test());
  locator.registerSingleton<API>(API());
  locator.registerLazySingleton<StorageService>(() => StorageService()); // lazySingleton refers to a class whose resource will not be initialised until its used for the 1st time
  //locator.registerFactory<StorageService>(() => StorageService()); // When you request an instance of the type from the service provider you'll get a new instance every time.

  // load languages if not in storage
  final langs = locator<StorageService>().localizedStrings;

  if (langs == null) {
    final res = await locator<API>().getLangs();

    //locator<StorageService>().localizedStrings = jsonEncode(res.data);
    print("save langs in storage: $res.data");
    locator<StorageService>().setVal('localizedStrings',  'fgdgdg');
  }
}