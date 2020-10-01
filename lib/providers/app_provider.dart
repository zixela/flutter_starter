import 'package:flutter/material.dart';

import '../services/index.dart';
import '../utils/locator.dart';

import '../config/global.dart' as CONFIG;

class AppProvider with ChangeNotifier {
  get localStorage => locator<StorageService>();
  get APIClient => locator<API>();

  AppProvider(this._Test);

  String _Test;

  get test => _Test;

  set (String test) {
    _Test = test;
    notifyListeners();
  }

  // Localization
  void initLocale() {
    final language = localStorage.language;
    APIClient.locale = language;
    _appLocale = Locale(language);
  }

  Locale _appLocale = CONFIG.COMMON.DEFAULT_LOCALE;

  Locale get appLocal => _appLocale ?? CONFIG.COMMON.DEFAULT_LOCALE;

  void changeLanguage(Locale locale) async {
    if (_appLocale == locale) {
      return;
    }
    _appLocale = locale;
    localStorage.language = locale.languageCode;
    localStorage.countryCode = locale.countryCode;
    notifyListeners();
  }

}