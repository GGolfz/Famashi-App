import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';

class Popup extends StatelessWidget {
  final widget;
  Popup({required this.widget});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Niku(widget),
    );
  }
}
