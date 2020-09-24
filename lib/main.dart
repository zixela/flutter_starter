import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';

import 'router/constants.dart';
import 'router/route_manager.dart';
import 'router/navigation_service.dart';

import 'utils/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //print(locator<Test>());
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider('sdsd')),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          //
          initialRoute: Routes.initialRoute,
          navigatorKey: NavigationService.instance.navigatorKey,
          onGenerateRoute: RouteManager.generateRoute,

        )
      );
  }
}

