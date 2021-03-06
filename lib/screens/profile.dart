import 'package:flutter/material.dart';

import '../services/index.dart';
import '../utils/locator.dart';

class Profile extends StatefulWidget {
  Profile();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    final ss = locator<StorageService>().getVal('test');
    print("profile: $ss");
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Profile',
            ),
          ],
        ),
      ),
    );
  }

}