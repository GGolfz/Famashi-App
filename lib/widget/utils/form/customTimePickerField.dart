import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/textField.dart';

class CustomTimePickerField extends StatelessWidget {
  final controller;
  final onTap;
  CustomTimePickerField({required this.controller, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return NikuTextField()
        .controller(controller)
        .outlined(color: kNeutral06, borderRadius: kBorderRadiusS)
        .bg(kNeutral06)
        .filled()
        .textStyle(kBody04Medium.copyWith(color: kNeutral02))
        .readOnly(true).on(tap:()=>onTap());
  }
}
