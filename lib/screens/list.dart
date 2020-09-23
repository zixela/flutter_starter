import 'package:flutter/material.dart';


class List extends StatefulWidget {
  List();

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {

  @override
  Widget build(BuildContext context) {
    print('_ListState');
    return Scaffold(
      appBar: AppBar(
        title: Text('sss'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'List widget',
            ),
          ],
        ),
      ),
    );
  }

}