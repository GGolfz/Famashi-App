import 'package:famashi/widget/layout/template.dart';
import 'package:flutter/material.dart';

class MedicineAddScreen extends StatelessWidget {
  static String routeName = '/medicine-add';
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
        child: Center(
          child: Text("Medicine Add Screen"),
        ),
        title: 'Add Medicine',isHome: false,);
  }
}
