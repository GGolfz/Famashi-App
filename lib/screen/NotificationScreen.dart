import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/notificationProvider.dart';
import 'package:famashi/utils/format.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/reminder/reminderGroup.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:famashi/widget/utils/instructionDialog.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  static String routeName = '/notification';
  @override
  Widget build(BuildContext context) {
    Provider.of<NotificationProvider>(context, listen: false)
        .fetchNotification();
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
      ]).crossCenter().mainAxisAlignment(MainAxisAlignment.spaceBetween),
      Expanded(child: SingleChildScrollView(
        child: Consumer<NotificationProvider>(builder: (ctx, notify, _) {
          List data = notify.notify!.getData(DateTime.now());
          List<Widget> widgets = [];
          for (var i in data) {
            widgets.add(
              ReminderGroup(
                  id: i["time_type"],
                  time: i["time"],
                  timeType: i["time_type"],
                  data: i["data"]),
            );
          }
          return NikuColumn(widgets);
        }),
      ))
    ])).padding(EdgeInsets.all(kSizeS)));
  }
}
