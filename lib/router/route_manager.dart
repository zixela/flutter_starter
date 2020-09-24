import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../screens/home.dart';
import '../screens/list.dart';
import '../screens/detail.dart';
import '../widgets/bottom_tabs.dart';

import '../router/constants.dart';

enum TransitionType {
  SLIDERIGHT,
  SLIDELEFT,
  SLIDETOP,
  SLIDEBOTTOM,
  FADE,
  SCALE,
  ROTATE,
  SIZE,
  SCALEROTATE,
}

class RouteManager {
  RouteManager._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Map<String, dynamic> args = settings.arguments;

    switch (settings.name) {
      case Routes.initialRoute:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return TabsPage();
            },
          );
        }
      case Routes.home:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return MyHomePage(title: "Home Page");
            },
          );
        }
      case Routes.list:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return List();
            },
          );
        }

      case Routes.detail:
        {
          return MaterialPageRoute(
            builder: (BuildContext context) {
              return Detail();
            },
          );
        }
      case Routes.anotherPageNativeTransition:
        {
          final bool fullscreenDialog = args["fullscreenDialog"];
          final String message = args["message"];
          final Color color = args["color"];

          if (Platform.isIOS) {
            return CupertinoPageRoute(
              fullscreenDialog: fullscreenDialog,
              builder: (BuildContext context) {
                return List();
              },
            );
          } else {
            return MaterialPageRoute(
              fullscreenDialog: fullscreenDialog,
              builder: (BuildContext context) {
                return List();
              },
            );
          }

          break;
        }

      case Routes.anotherPageTransition:
        {
          final TransitionType type = args["transitionType"] as TransitionType;
          final String message = args["message"];
          final Color color = args["color"];

          return PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return List();
            },

            /// Süre Verebiliriz.
            /// transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return _transitionsBuilder(type, animation, child);
            },
          );
        }

      default:
        {
          return _errorPage();
        }
    }
  }

  static Widget _transitionsBuilder(
      TransitionType type, Animation<double> animation, Widget child) {
    switch (type) {
      case TransitionType.SLIDERIGHT:
        {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(
              /// Curved Animasyon Verebiliriz. Vermezsek "Linear" Gerçeleşir.
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          );
        }

      case TransitionType.SLIDELEFT:
        {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }

      case TransitionType.SLIDETOP:
        {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }

      case TransitionType.SLIDEBOTTOM:
        {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        }

      case TransitionType.FADE:
        {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }

      case TransitionType.SCALE:
        {
          return ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          );
        }

      case TransitionType.ROTATE:
        {
          return RotationTransition(
            turns: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          );
        }

      case TransitionType.SIZE:
        {
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          );
        }

      case TransitionType.SCALEROTATE:
        {
          return ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: RotationTransition(
              turns: Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.linear,
                ),
              ),
              child: child,
            ),
          );
        }

      default:
        break;
    }
  }

  static Route<dynamic> _errorPage() {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Navigation Error',
            ),
          ),
          body: Center(
            child: Text(
              'Navigation Error',
            ),
          ),
        );
      },
    );
  }
}