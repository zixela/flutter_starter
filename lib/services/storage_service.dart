import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class StorageService {

  StorageService _storageService;
  SharedPreferences _preferences;


  Future<StorageService> getInstance() async {
    if (_storageService == null) {
      _storageService = StorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    print('get instance');
    return _storageService;
  }

  StorageService();

  getVal<T>(key) {
    if (_preferences == null) return null;

    if (T == String) return _preferences.getString(key);

    if (T == bool) return _preferences.getBool(key);

    if (T == int) return _preferences.getInt(key);

    if (T == double) return _preferences.getDouble(key);

    if (T == List) return _preferences.getStringList(key);

    return _preferences.get(key);
  }

  Future<bool> setVal<T>(String key, T content) {
    if (_preferences == null) return null;

    if (content is String) {
      return _preferences.setString(key, content);
    }
    if (content is bool) {
      return _preferences.setBool(key, content);
    }
    if (content is int) {
      return _preferences.setInt(key, content);
    }
    if (content is double) {
      return _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      return _preferences.setStringList(key, content);
    }
  }

  Future<bool> remove(String key) {
    if (_preferences == null) return null;

    return _preferences.remove(key);
  }

  set localizedStrings(String m) => this.setVal('localizedStrings', m);

  dynamic get localizedStrings {
    final json = this.getVal('localizedStrings');
    if (json != null) return jsonDecode(json);
    return null;
  }

}