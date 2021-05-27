import 'dart:async';

import 'package:famashi/config/constant.dart';
import 'package:famashi/screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:niku/widget/base.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2, milliseconds: 800), () {
      Navigator.of(context).pushNamed(HomeScreen.routeName);
    });
    return Scaffold(
      body: Niku(
        Lottie.asset('assets/animation/FamashiLogo.json'),
      ).center().padding(EdgeInsets.all(kSizeM)),
    );
  }
}
