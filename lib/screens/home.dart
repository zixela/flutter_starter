import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

import '../router/constants.dart';
import '../router/route_manager.dart';
import '../router/navigation_service.dart';

import '../widgets/drawer.dart';

import '../services/index.dart';
import '../utils/locator.dart';
import '../widgets/txt.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final arguments = {
    "transitionType": TransitionType.SLIDERIGHT,
    "message": "Message Displays Here.",
    "color": Colors.greenAccent,
  };

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void goToList() {
    NavigationService.instance.pushNamed(
      Routes.anotherPageTransition,
      args: arguments,
    ).then((data) {
      print("data from back click: $data");
    });
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.set('new state');

    locator<StorageService>().setVal('test', 'test data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Txt('l_about')
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: goToList,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}