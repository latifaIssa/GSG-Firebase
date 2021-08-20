import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
