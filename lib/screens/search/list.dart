import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import './search_item.dart';


class List extends StatefulWidget {
  List();

  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    //print(appProvider.test);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: Container(
        color: Color.fromRGBO(242, 242, 246, 1),
        child: Center(
          child:ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return SearchItem();
              }
          ),
        ),
      ),
    );
  }

}