import 'package:famashi/widget/layout/template.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
        child: Center(
          child: Text("Home Screen"),
        ),
        title: 'Home');
  }
}
