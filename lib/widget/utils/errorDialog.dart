import 'package:flutter/material.dart';
import 'package:niku/widget/text.dart';

class ErrorDialog extends StatelessWidget {
  final String error;
  ErrorDialog({required this.error});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: NikuText(error),
    );
  }
}
