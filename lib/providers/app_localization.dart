import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/index.dart';
import '../utils/locator.dart';


class AppLocalizations {
  final Locale locale;

  Map _localizedStrings;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Future<bool> load() async {
    try {
      final localStorage = locator<StorageService>();

      final langs = localStorage.localizedStrings;

      if (langs == null) {
        return _getFromRootBundle();
      } else {
        localizedStrings = langs[locale.languageCode];
        return true;
      }
    } catch (e) {
      print('AppLocalizations load $e');
      return false;
    }
  }

  Future<bool> _getFromRootBundle() async {
    try {
      final kaJson = await rootBundle.loadString('assets/i18n/ka.json');
      //localizedStrings = jsonDecode(kaJson);
      return true;
    } catch (e) {
      print('_getLangFromRootBundle  $e');
      return false;
    }
  }

  set localizedStrings(Map langs) {
    _localizedStrings = langs.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) {
    print(locator<StorageService>().getVal('localizedStrings'));
    if (_localizedStrings == null || _localizedStrings[key] == null) return key;
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ka', 'en', 'ru', 'az', 'hy'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
