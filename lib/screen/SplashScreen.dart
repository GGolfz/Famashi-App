import 'dart:async';

import 'package:famashi/config/constant.dart';
import 'package:famashi/screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:niku/widget/base.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3, milliseconds: 200), () {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Niku(
        Lottie.asset('assets/animation/FamashiLogo.json', repeat: false),
      ).center().padding(EdgeInsets.all(kSizeM)),
    );
  }
}
