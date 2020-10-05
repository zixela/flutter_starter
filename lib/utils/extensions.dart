import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../providers/app_localization.dart';
import '../widgets/loader.dart';

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

extension BuildContextExt on BuildContext {
  Future push(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  Future pushNamed(String routeName, {Object arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future pushReplacementNamed(String routeName, {Object arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future pushReplacement(Widget page) {
    return Navigator.of(this)
        .pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  void pop([res]) {
    Navigator.of(this).pop(res);
  }

  void showLoader() {
    this.showBlurredDialog(
      content: Loader(),
      alignment: Alignment.center,
      barrierDismissible: false,
    );
  }

  Future showBlurredDialog({
    @required Widget content,
    Alignment alignment = Alignment.bottomCenter,
    bool barrierDismissible = true,
  }) {
    final theme = Theme.of(this);
    return showGeneralDialog(
      context: this,
      barrierDismissible: barrierDismissible,
      barrierLabel: 'Hello',
      transitionBuilder: (context, a1, _, __) {
        final curvedValue = Curves.easeInOut.transform(a1.value) - 1;
        final deviceSize = MediaQuery.of(context).size;
        final _scale = lerpDouble(0, 1, Curves.easeOut.transform(a1.value));
        final bottomPadding = max(MediaQuery.of(context).viewInsets.bottom,
            MediaQuery.of(context).padding.bottom);

        return Transform(
          transform: Matrix4.identity()
            ..translate(
              curvedValue * -deviceSize.width / 3,
              curvedValue * -deviceSize.height,
            )
            ..scale(_scale),
          child: Opacity(
            opacity: _scale,
            child: Container(
              padding: EdgeInsets.only(bottom: bottomPadding),
              height: deviceSize.height,
              width: deviceSize.width,
              alignment: alignment,
              child: BackdropFilter(
                filter:
                ImageFilter.blur(sigmaX: 10 * _scale, sigmaY: 10 * _scale),
                child: content,
              ),
            ),
          ),
        );
      },
      barrierColor: Color.fromRGBO(216, 216, 216, 0.6),
      transitionDuration: const Duration(milliseconds: 180),
      // ignore: missing_return
      pageBuilder: (_, __, ___) {},
    );
  }
}

