import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/text.dart';

class CustomSelector extends StatelessWidget {
  final String current;
  final List<String> items;
  final Function onChange;
  CustomSelector(
      {required this.current, required this.items, required this.onChange});
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items
          .map((e) => DropdownMenuItem<String>(value: e, child: NikuText(e)))
          .toList(),
      value: current,
      onChanged: (val) {
        onChange(val);
      },
      icon: Icon(
        Iconly.arrow_down_2,
        color: kNeutral03,
      ),
      style: kBody04Medium.copyWith(color: kNeutral02),
      decoration: InputDecoration(
          fillColor: kNeutral06,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none, borderRadius: kBorderRadiusS)),
    );
  }
}
