import 'package:famashi/screen/medicine/MedicineAddScreen.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
        child: Center(
          child: Text("Home Screen"),
        ),
        title: 'Home',
        hasAction: true,
        action: () {
          Navigator.of(context).pushNamed(MedicineAddScreen.routeName);
        });
  }
}
