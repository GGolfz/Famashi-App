import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/medicalProvider.dart';
import 'package:famashi/screen/health-info/HealthInfoEditScreen.dart';
import 'package:famashi/widget/health/detailTile.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class GeneralInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<MedicalProvider>(context, listen: false).fetchMeidcalInfo();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kSizeS, vertical: kSizeS),
      child: Consumer<MedicalProvider>(
          builder: (ctx, medical, _) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                  ),
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
    );
  }
}
