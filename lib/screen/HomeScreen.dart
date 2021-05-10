import 'package:famashi/widget/layout/appbar.dart';
import 'package:famashi/widget/layout/drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
      appBar: FamashiAppbar(title: 'Home'),
      drawer: FamashiDrawer(),
    );
  }
}
