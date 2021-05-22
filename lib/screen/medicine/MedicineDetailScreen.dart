import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:famashi/widget/medicine/functionTab.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';

class MedicineDetailScreen extends StatelessWidget {
  static String routeName = '/medicine-detail';
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
      child: Niku(NikuColumn([
        NikuColumn([
          FunctionTab(
            medicineId: "1",
          ),
          kSizedBoxVerticalXS,
          NikuText("Remaining 12 out of 20")
              .style(kBody04Medium.copyWith(color: kNeutral03)),
          kSizedBoxVerticalM,
          MedicineImage(),
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
              ],
            ),
          )
        ]),
        kSizedBoxVerticalXL,
        kSizedBoxVerticalL,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(kPrimaryColor04),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          side: BorderSide(color: kPrimaryColor04)))),
              child: NikuText("Information Leaflet")
                  .style(kBody04Medium.copyWith(color: kPrimaryColor04)),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Niku(
                          NikuColumn([
                            NikuRow([
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Iconly.close_square)),
                            ]).mainEnd(),
                            Niku(NikuText("Information Leaflet").style(
                                kBody03Semibold.copyWith(color: kNeutral02))),
                          ]),
                        ).height(100).width(160),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ]).crossAxisAlignment(CrossAxisAlignment.stretch)),
      title: 'My Medicine',
      isHome: false,
    );
  }
}
