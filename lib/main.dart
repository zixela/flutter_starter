import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'providers/app_provider.dart';
import 'providers/app_localization.dart';

import 'router/constants.dart';
import 'router/route_manager.dart';
import 'router/navigation_service.dart';

import 'utils/locator.dart';
import 'utils/extensions.dart';
import 'services/index.dart';

import 'config/global.dart' as CONFIG;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  List<LocalizationsDelegate> get _localizationsDelegates {
    return [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ];
  }

  @override
  Widget build(BuildContext context) {



    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppProvider>(
              create: (_) => AppProvider('sdsd')),
        ],
        builder: (BuildContext ctx, _) {

          final appLocale = AppProvider != null
              ? ctx.select((AppProvider p) => p.appLocal)
              : CONFIG.COMMON.DEFAULT_LOCALE;

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
            localizationsDelegates: _localizationsDelegates,
            supportedLocales: CONFIG.COMMON.SUPPORTED_LOCALES,
            locale: appLocale,
          );
        });
  }
}
