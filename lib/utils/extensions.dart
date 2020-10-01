import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../providers/app_localization.dart';


extension StringExt on String {
  /*
  Returns translated string
  @var context is necessary
 */
  // ignore: always_declare_return_types
  operator /(BuildContext context) {
    if (AppLocalizations.of(context) != null) {
      return AppLocalizations.of(context).translate(this) ?? this;
    }
    return this;
  }

  String get icon => 'assets/images/$this\_icon.png';

  void log() {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(this).forEach((match) => print(match.group(0)));
  }

  String get phoneFormat {
    if (this == null) return '';
    String p;
    if (this.length == 12)
      p = this.substring(3, this.length);
    else if (this.length == 9) p = this;
    if (p.length == 9)
      return '${p.substring(0, 3)} ${p.substring(3, 5)} ${p.substring(5, 7)} ${p.substring(7, 9)}';
    return this;
  }

}

