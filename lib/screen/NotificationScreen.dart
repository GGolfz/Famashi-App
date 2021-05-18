import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:famashi/widget/utils/instructionDialog.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = '/notification';
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
        child: Niku(NikuColumn([
      NikuRow([
        NikuText("Notification").style(kBody01Semibold),
        Niku(Icon(
          Iconly.info_square,
          color: kNeutral02,
          size: kSizeS * 1.75,
        )).on(tap: () {
          showDialog(context: context, builder: (ctx) => InstructionDialog());
        })
      ]).crossCenter().mainAxisAlignment(MainAxisAlignment.spaceBetween)
    ])).padding(EdgeInsets.all(kSizeS)));
  }
}
