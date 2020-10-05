import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../providers/app_provider.dart';
import '../services/storage_service.dart';
import '../utils/locator.dart';
import '../config/global.dart';
import '../utils/extensions.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    _changeLang(e) async{
      if (locator<StorageService>().language != e.languageCode) {
        context.showLoader();
        try {
          locator<StorageService>().language = e.languageCode;
        } catch (e) {
          print('CHANGE LANGUAGE  $e');
        }
        print('change lang');
        await locator.reset();
        await setupLocator();
        context.read<AppProvider>().changeLanguage(e);
        context.pop();
      }
    }

    final locale = context.select((AppProvider p) => p.appLocal);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Row(
              children: [
                ...COMMON.SUPPORTED_LOCALES
                    .map((e) =>
                    Container(
                      width: 50,
                      child: Opacity(
                        opacity: e == locale ? 0.3 : 1,
                        child: FlatButton(
                          onPressed: () async {
                            _changeLang(e);
                          },
                          child: Text( e.languageCode),
                        ),
                      ),
                    ))
              ]
          ),
        ],
      ),

    );
  }
}
