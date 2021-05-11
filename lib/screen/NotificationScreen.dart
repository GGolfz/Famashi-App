import 'package:famashi/widget/layout/template.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = '/notification';
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
        child: Center(
          child: Text("Notification Screen"),
        ),
        title: 'Notification');
  }
}
