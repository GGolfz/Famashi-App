import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/utils/okButton.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/text.dart';

class ErrorDialog extends StatelessWidget {
  final String error;
  ErrorDialog({required this.error});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 16,
      title: NikuText("An error occured").style(kBody02Medium),
      contentPadding: EdgeInsets.all(kSizeS * 1.5),
      content: NikuText(error).style(kBody03),
      actions: [
        OkButton(onPressed: () async {
          Navigator.of(context).pop();
        })
      ],
      actionsPadding: EdgeInsets.all(kSizeS),
    );
  }
}
