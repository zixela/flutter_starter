import 'dart:ui';

class COMMON {
  static const DIR_SEPARATOR = '/';
  static const API_URL = 'https://api2.myauto.ge';
  static const DEFAULT_LANGUAGE = 'ka';
  static const REQUEST_STRICT_MODE = false;

  static List<Locale> get SUPPORTED_LOCALES {
    return [
      const Locale('ka'),
      const Locale('en'),
      const Locale('ru'),
      const Locale('az'),
      const Locale('hy')
    ];
  }

  static const DEFAULT_LOCALE = const Locale(DEFAULT_LANGUAGE);
}