import 'package:flutter/material.dart';

import '../router/constants.dart';
import '../router/route_manager.dart';
import '../router/navigation_service.dart';

import '../widgets/drawer.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final arguments = {
    "transitionType": TransitionType.SCALEROTATE,
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
      print("$data");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Text('test'),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: goToList,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}