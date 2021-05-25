import 'package:famashi/config/color.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/utils/cancelButton.dart';
import 'package:famashi/widget/utils/deleteButton.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/button.dart';
import 'package:niku/widget/text.dart';

class DeleteDialog extends StatelessWidget {
  final text;
  final onDelete;
  DeleteDialog({required this.text, required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 16,
      title: NikuText("Are you sure to delete this $text?")
          .style(kBody02Semibold)
          .alignCenter(),
      content: NikuRow([
        Flexible(flex: 1, child: CancelButton()),
        Flexible(
            flex: 1,
            child: DeleteButton(onPressed: () async {
              await onDelete();
            }))
      ]).mainEnd(),
    );
  }
}
