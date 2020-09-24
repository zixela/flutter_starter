import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  AppProvider(this._Test);

  String _Test;

  get test => _Test;

  set (String test) {
    _Test = test;
    notifyListeners();
  }
}