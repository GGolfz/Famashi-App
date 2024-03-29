import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/medicine/functionTab.dart';
import 'package:famashi/widget/medicine/informationLeaflet.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class MedicineDetail extends StatelessWidget {
  final int medicineID;
  final String medicineName;
  final String? medicineImage;
  final int remainAmount;
  final String description;
  final int totalReceived;
  final int dosagePerDose;
  final String medicineUnit;
  final List<String> reminder;
  final String? leafletImage;
  MedicineDetail(
      {required this.medicineID,
      required this.medicineName,
      required this.medicineImage,
      required this.remainAmount,
      required this.description,
      required this.totalReceived,
      required this.dosagePerDose,
      required this.medicineUnit,
      required this.reminder,
      required this.leafletImage});
  @override
  Widget build(BuildContext context) {
    return NikuColumn([
      FunctionTab(medicineId: medicineID.toString()),
      RichText(
          text: TextSpan(children: [
        TextSpan(
            text: 'Remaining ',
            style: kBody04Medium.copyWith(color: kNeutral03)),
        TextSpan(
            text: '${remainAmount.toString()}',
            style: kBody03Medium.copyWith(color: kAccentColor01)),
        TextSpan(
            text: " out of ${totalReceived.toString()}",
            style: kBody04Medium.copyWith(color: kNeutral03))
      ])),
      kSizedBoxVerticalM,
      MedicineImage(
        medicineImage: medicineImage,
      ),
      kSizedBoxVerticalS,
      NikuText(medicineName).style(kBody04SemiBold.copyWith(color: kNeutral02)),
      kSizedBoxVerticalM,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: NikuColumn(
          [
            NikuText("Description")
                .style(kBody04SemiBold.copyWith(color: kPrimaryColor04)),
            kSizedBoxVerticalXS,
            NikuText(description)
                .style(kBody05Medium.copyWith(color: kNeutral03)),
            kSizedBoxVerticalS,
            NikuText("Total Received")
                .style(kBody04SemiBold.copyWith(color: kPrimaryColor04)),
            kSizedBoxVerticalXS,
            NikuText(totalReceived.toString())
                .style(kBody05Medium.copyWith(color: kNeutral03)),
            kSizedBoxVerticalS,
            NikuText("Dosage per dose")
                .style(kBody04SemiBold.copyWith(color: kPrimaryColor04)),
            kSizedBoxVerticalXS,
            NikuText(dosagePerDose.toString())
                .style(kBody05Medium.copyWith(color: kNeutral03)),
            kSizedBoxVerticalS,
            NikuText("Medicine unit")
                .style(kBody04SemiBold.copyWith(color: kPrimaryColor04)),
            kSizedBoxVerticalXS,
            NikuText(medicineUnit)
                .style(kBody05Medium.copyWith(color: kNeutral03)),
            kSizedBoxVerticalS,
            NikuText("Medicine reminder")
                .style(kBody04SemiBold.copyWith(color: kPrimaryColor04)),
            kSizedBoxVerticalXS,
            NikuText(reminder.join(',\n'))
                .style(kBody05Medium.copyWith(color: kNeutral03)),
            kSizedBoxVerticalS,
            if (leafletImage != null)
              InformationLeaflet(leafletImage: leafletImage),
            kSizedBoxVerticalM,
          ],
        ).crossAxisAlignment(CrossAxisAlignment.stretch).mainStart(),
      )
    ]);
  }
}
