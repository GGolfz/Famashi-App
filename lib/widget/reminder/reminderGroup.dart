import 'package:famashi/utils/format.dart';
import 'package:famashi/widget/medicine/medicineInfo.dart';
import 'package:famashi/widget/reminder/reminderInfo.dart';
import 'package:flutter/material.dart';
import 'package:famashi/provider/notificationProvider.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class ReminderGroup extends StatelessWidget {
  int timeType;
  String time;
  List<MedicineNotify> data;
  ReminderGroup(
      {required this.time, required this.timeType, required this.data});
  @override
  Widget build(BuildContext context) {
    return Niku(NikuColumn([
      NikuRow([
        NikuText(formatTimeTypeToString(timeType).toString()),
        NikuText("$time")
      ]).spaceBetween(),
      NikuRow([
        Wrap(
          alignment: WrapAlignment.start,
          children: data
              .map((e) => ReminderInfo(
                    reminderID: e.reminderId,
                    medicineImage: e.medicineImage,
                    medicineName: e.medicineName.toString(),
                    dosageAmount: e.dosageAmount,
                    medicineUnit: e.medicineUnit,
                  ))
              .toList(),
        )
      ])
    ]));
  }
}
