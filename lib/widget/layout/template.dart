import 'package:famashi/config/color.dart';
import 'package:famashi/widget/layout/appbar.dart';
import 'package:famashi/widget/layout/drawer.dart';
import 'package:flutter/material.dart';

class TemplateLayout extends StatelessWidget {
  final isHome;
  final title;
  final child;
  final hasAction;
  final action;
  TemplateLayout(
      {this.isHome = true,
      this.title = '',
      this.child,
      this.hasAction = false,
      this.action});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      appBar: FamashiAppbar(
        title: title,
        isHome: isHome,
      ),
      drawer: FamashiDrawer(),
      floatingActionButton: hasAction
          ? FloatingActionButton(
              onPressed: this.action,
              child: Icon(Icons.add),
              backgroundColor: kPrimaryColor04,
              splashColor: kPrimaryColor03,
              elevation: 0,
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
