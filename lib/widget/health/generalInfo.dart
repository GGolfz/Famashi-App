import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/medicalProvider.dart';
import 'package:famashi/screen/health-info/HealthInfoEditScreen.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/health/detailTile.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class GeneralInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    try {
      Provider.of<MedicalProvider>(context, listen: false).fetchMeidcalInfo();
    } on ErrorResponse catch (error) {
      if (error.toString() == "Unauthorize") {
        Provider.of<AuthenticateProvider>(context, listen: false).logout();
      } else {
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialog(error: error.toString()));
      }
    }
    return Niku(
      Consumer<MedicalProvider>(
          builder: (ctx, medical, _) => NikuColumn(
                [
                  NikuRow(
                    [
                      NikuText("General Information")
                          .style(kBody02Semibold)
                          .color(kNeutral02),
                      Niku(NikuText("edit")
                              .style(kBody04Medium)
                              .color(kPrimaryColor05)
                              .textDecoration(TextDecoration.underline))
                          .on(tap: () {
                        Navigator.of(context)
                            .pushNamed(HealthInfoEditScreen.routeName);
                      })
                    ],
                  ).spaceBetween(),
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (ctx, index) => DetailTile(
                        title: medical.medicalInfo!.report[index]["title"]
                            .toString(),
                        detail: medical.medicalInfo!.report[index]["detail"]
                            .toString()),
                    itemCount: medical.medicalInfo != null
                        ? medical.medicalInfo?.report.length
                        : 0,
                  ))
                ],
              )),
    ).padding(EdgeInsets.symmetric(horizontal: kSizeS, vertical: kSizeS));
  }
}
