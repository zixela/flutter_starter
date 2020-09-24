import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/app_provider.dart';


class List extends StatefulWidget {
  List();

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'List widget',
            ),
            Text(
              appProvider.test,
            ),
          ],
        ),
      ),
    );
  }

}