import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/textField.dart';

class CustomDatePicker extends StatelessWidget {
  DateTime current;
  Function onChange;
  CustomDatePicker({required this.current, required this.onChange});
  @override
  Widget build(BuildContext context) {
    return NikuTextField()
        .controller(TextEditingController.fromValue(TextEditingValue(
            text: "${current.day}/${current.month}/${current.year}")))
        .outlined(color: kNeutral06, borderRadius: kBorderRadiusS)
        .bg(kNeutral06)
        .filled()
        .textStyle(kBody04Medium.copyWith(color: kNeutral02))
        .readOnly(true)
        .on(tap: () async {
      var now = DateTime.now();
      final date = await showDatePicker(
          context: context,
          initialDate: current == null ? now : current,
          firstDate: DateTime(now.year - 120, now.month, now.day),
          lastDate: DateTime(now.year + 120, now.month, now.day));
      if (date != null) {
        onChange(date);
      }
    });
  }
}
