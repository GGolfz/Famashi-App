import 'package:famashi/config/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/button.dart';
import 'package:niku/widget/text.dart';

class CustomTimePicker extends StatelessWidget {
  final onSave;
  final currentValue;
  CustomTimePicker({required this.onSave, required this.currentValue});
  var value;
  @override
  Widget build(BuildContext context) {
    return Niku(NikuColumn([
      NikuRow([
        NikuButton(NikuText("Save")).onPressed(() {
          onSave(value);
        })
      ]),
      CupertinoTimerPicker(
        mode: CupertinoTimerPickerMode.hm,
        onTimerDurationChanged: (time) {
          value = time;
        },
        initialTimerDuration: currentValue,
      )
    ]).crossEnd())
        .fitted()
        .padding(EdgeInsets.all(kSizeS));
  }
}
