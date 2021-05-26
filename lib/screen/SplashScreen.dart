import 'dart:async';

import 'package:famashi/config/logo.dart';
import 'package:famashi/screen/HomeScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1, milliseconds: 700), () {
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    });
    return Scaffold(
      body: Center(
        child: kLongLogo2,
      ),
    );
  }
}
