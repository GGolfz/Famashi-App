import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';

class Popup extends StatelessWidget {
  final widget;
  Popup({required this.widget});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 16,
      child: Niku(widget),
    );
  }
}
