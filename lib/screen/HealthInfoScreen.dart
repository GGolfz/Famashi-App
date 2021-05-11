import 'package:famashi/widget/layout/appbar.dart';
import 'package:famashi/widget/layout/drawer.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:flutter/material.dart';

class HealthInfoScreen extends StatelessWidget {
  static String routeName = '/healthinfo';
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
        child: Center(
          child: Text("Health Info Screen"),
        ),
        title: 'Health Info');
  }
}
