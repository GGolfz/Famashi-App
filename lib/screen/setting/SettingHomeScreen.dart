import 'package:famashi/widget/layout/template.dart';
import 'package:flutter/material.dart';

class SettingHomeScreen extends StatelessWidget {
  static String routeName = '/setting';
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
        child: Center(
          child: Text("Setting Home Screen"),
        ),
        title: 'Setting');
  }
}
