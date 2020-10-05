import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/screenutil.dart';

import 'providers/app_provider.dart';
import 'providers/app_localization.dart';

import 'router/constants.dart';
import 'router/route_manager.dart';
import 'router/navigation_service.dart';

import 'utils/locator.dart';
import 'utils/extensions.dart';

import 'services/index.dart';

import 'widgets/loader.dart';

import 'config/global.dart' as CONFIG;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  bool langsLoaded = false;

  @override
  void initState() {
    print('init app');
    _init();
  }

  void _init() async {
    final locatorsInitialized = await setupLocator();
    if (locatorsInitialized != true) {
      return;
    } else {
      langsLoaded = true;
    }
    setState(() {});
  }

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
    print('init main widget');
    if (langsLoaded == false) {
      return MaterialApp(
        color: Colors.white,
        home: Builder(
          builder: (BuildContext ctx) {
            //ScreenUtil.init(designSize: Size(375, 734), allowFontScaling: true);
            return Container(
              color:  Colors.white,
              child: Center(child: Loader()),
            );
          },
        ),
      );
    }

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AppProvider>(
              create: (_) => AppProvider('Test app data')),
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
