import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 30,
      height: 30,
      child: FlareActor(
        'assets/anim/loader_anim.flr',
        fit: BoxFit.cover,
        color: Color(0xffff8600),
        animation: 'loader',
      ),
    );
  }
}

class ModalLoader extends StatelessWidget {
  final bool dismissible, loading;
  final Widget child;

  ModalLoader({this.dismissible = false, this.child, this.loading = false});

  @override
  Widget build(BuildContext context) {
    if (!loading) return child;
    return Stack(
      children: [
        child,
        Opacity(
          child: ModalBarrier(
              dismissible: dismissible,
              color: Colors.white),
          opacity: .3,
        ),
        Center(child: Loader()),
      ],
    );
  }
}
