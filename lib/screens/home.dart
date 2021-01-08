import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_provider.dart';

import '../router/constants.dart';
import '../router/route_manager.dart';
import '../router/navigation_service.dart';

import '../widgets/drawer.dart';
import '../widgets/otp.dart';

import '../services/index.dart';
import '../utils/locator.dart';
import '../utils/extensions.dart';
import '../widgets/txt.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool hasError = false;
  bool hasSuccess = false;

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

  void setError(val) {
    setState(() {
      hasError = val;
    });
  }

  void setSuccess(val) {
    setState(() {
      hasSuccess = val;
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

  Future<void>test() async {
    final String rawSvg = '<svg height="100" width="100"><circle cx="50" cy="50" r="40" stroke="black" stroke-width="3" fill="red" /></svg>';
    final DrawableRoot svgRoot = await svg.fromSvgString(rawSvg, rawSvg);
    final Picture  picture = svgRoot.toPicture();
    return picture.toImage(100, 200);
  }

  @override
  Widget build(BuildContext context) {

    void printCode(code) {
      this.setError(code != '1234');
      this.setSuccess(code == '1234');
      print(code);
    }

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
       /* backgroundColor: theme.dividerColor,*/
      ),
      body: Column(
        children: [
          Otp(
            codeLength: 4,
            numeric: true,
            obscureText: false,
            callBack: printCode,
            title: 'ჩაწერეთ სმს კოდი',
            errorText: 'კოდი არ არის სწორი',
            hasError: hasError,
            hasSuccess: hasSuccess,
          ),
          /* Center(
              child: Txt('l_about' / context)
          ),
          SvgPicture.asset('assets/svg/flutter_logo.svg'),
          SvgPicture.asset(
            'assets/svg/icons/new-camera.svg',
            color: Colors.red,
            matchTextDirection: true,
          ),
          SvgPicture.network(
            'http://upload.wikimedia.org/wikipedia/commons/0/02/SVG_logo.svg',
            semanticsLabel: 'A shark?!',
            placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator()),
          ),*/

        ],
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