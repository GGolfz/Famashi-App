import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/notificationProvider.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/emptyNotification.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/reminder/reminderGroup.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:famashi/widget/utils/instructionDialog.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  static String routeName = '/notification';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var _selectedId = -1;
  void _onSelect(id) {
    setState(() {
      _selectedId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    try {
      Provider.of<NotificationProvider>(context, listen: false)
          .fetchNotification();
    } on ErrorResponse catch (error) {
      if (error.toString() == "Unauthorize") {
        Provider.of<AuthenticateProvider>(context, listen: false).logout();
      } else {
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialog(error: error.toString()));
      }
    }
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
      kSizedBoxVerticalS,
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
                data: i["data"],
                selectedId: _selectedId,
                onSelect: (val) => _onSelect(val),
              ),
            );
          }
          if (widgets.length == 0) {
            widgets.add(EmptyNotification());
          }
          return NikuColumn(widgets);
        }),
      ))
    ])).padding(EdgeInsets.all(kSizeS)));
  }
}
