import 'package:famashi/widget/layout/appbar.dart';
import 'package:famashi/widget/layout/drawer.dart';
import 'package:flutter/material.dart';

class TemplateLayout extends StatelessWidget {
  final isHome;
  final title;
  final child;
  TemplateLayout({this.isHome = true, this.title, this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      appBar: FamashiAppbar(
        title: title,
        isHome: isHome,
      ),
      drawer: FamashiDrawer(),
    );
  }
}
