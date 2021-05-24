import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/medicine/functionTab.dart';
import 'package:famashi/widget/medicine/informationLeaflet.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/text.dart';

class MedicineDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NikuColumn(
      [
        FunctionTab(medicineId: "1"),
        NikuText("Remaining 12 out of 20")
              .style(kBody04Medium.copyWith(color: kNeutral03)),
          kSizedBoxVerticalM,
          MedicineImage(medicineImage: null,),
          kSizedBoxVerticalS,
          NikuText("Drug Name")
              .style(kBody04SemiBold.copyWith(color: kNeutral02)),
          kSizedBoxVerticalM,
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NikuText("Description")
                    .style(kBody04SemiBold.copyWith(color: kPrimaryColor04)),
                kSizedBoxVerticalXS,
                NikuText("Lorem ipsum dolor sit amet consectetur")
                    .style(kBody05Medium.copyWith(color: kNeutral03)),
                    kSizedBoxVerticalS,
                NikuText("Total Received")
                    .style(kBody04SemiBold.copyWith(color: kPrimaryColor04)),
                kSizedBoxVerticalXS,
                NikuText("amount")
                    .style(kBody05Medium.copyWith(color: kNeutral03)),
                     kSizedBoxVerticalS,
                NikuText("Dosage per dose")
                    .style(kBody04SemiBold.copyWith(color: kPrimaryColor04)),
                kSizedBoxVerticalXS,
                NikuText("amount")
                    .style(kBody05Medium.copyWith(color: kNeutral03)),
                     kSizedBoxVerticalS,
                NikuText("Medicine unit")
                    .style(kBody04SemiBold.copyWith(color: kPrimaryColor04)),
                kSizedBoxVerticalXS,
                NikuText("pill")
                    .style(kBody05Medium.copyWith(color: kNeutral03)),
                     kSizedBoxVerticalS,
                NikuText("Set medicine reminder")
                    .style(kBody04SemiBold.copyWith(color: kPrimaryColor04)),
                kSizedBoxVerticalXS,
                NikuText("before morning")
                    .style(kBody05Medium.copyWith(color: kNeutral03)),
                    kSizedBoxVerticalXS,
                InformationLeaflet(),
              ],
            ),
          )
      ]
    );
  }
}