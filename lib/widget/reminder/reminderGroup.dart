import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/utils/format.dart';
import 'package:famashi/widget/medicine/medicineInfo.dart';
import 'package:famashi/widget/reminder/reminderInfo.dart';
import 'package:flutter/material.dart';
import 'package:famashi/provider/notificationProvider.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class ReminderGroup extends StatelessWidget {
  final int id;
  final int timeType;
  final String time;
  final List<MedicineNotify> data;
  final Function onSelect;
  final int selectedId;
  ReminderGroup(
      {required this.id,
      required this.time,
      required this.timeType,
      required this.data,
      required this.onSelect,
      required this.selectedId});
  @override
  Widget build(BuildContext context) {
    return Niku(
            NikuColumn([
              Padding(
                  padding: EdgeInsets.only(left: kSizeS, right: kSizeXS * 1.5),
                  child: NikuRow([
                    NikuText(formatTimeTypeToString(timeType).toString())
                        .style(kBody04Medium)
                        .color(kPrimaryColor05),
                    NikuText("$time")
                        .style(kBody04SemiBold)
                        .color(kAccentColor01)
                  ]).spaceBetween()),
              Expanded(
                  child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 12,
                children: data
                    .map((e) => ReminderInfo(
                          reminderID: e.reminderId,
                          medicineImage: e.medicineImage,
                          medicineName: e.medicineName.toString(),
                          dosageAmount: e.dosageAmount,
                          medicineUnit: e.medicineUnit,
                          onSelect: onSelect,
                          selectedID: selectedId,
                        ))
                    .toList(),
              ))
            ]).crossStart(),
            Key(timeType.toString()))
        .height(30 + 280.0 * (data.length / 2).round());
  }
}
