import 'package:flutter/material.dart';

import 'router/constants.dart';
import 'router/route_manager.dart';
import 'router/navigation_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //
      initialRoute: Routes.initialRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
      onGenerateRoute: RouteManager.generateRoute,

    );
  }
}

