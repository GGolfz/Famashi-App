import 'package:flutter/material.dart';
import 'package:niku/widget/text.dart';
import 'package:niku/widget/textField.dart';

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
    );
  }
}
