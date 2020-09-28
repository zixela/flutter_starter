import 'package:get_it/get_it.dart';

import '../services/storage_service.dart';
import '../services/test.dart';

final GetIt locator = GetIt.instance;

void setupLocator() async {

  locator.registerSingleton<Test>(Test());
  locator.registerLazySingleton<StorageService>(() => StorageService()); // lazySingleton refers to a class whose resource will not be initialised until its used for the 1st time
  //locator.registerFactory<StorageService>(() => StorageService()); // When you request an instance of the type from the service provider you'll get a new instance every time.
}