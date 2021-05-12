import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/health/detailTile.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class GeneralInfo extends StatelessWidget {
  final List<Map<String, String>> data = [
    {"title": "Gender", "detail": "Female"},
    {"title": "Birthdate", "detail": "01/01/2020"},
    {"title": "Weight", "detail": "0 kg."},
    {"title": "Height", "detail": "0 cm."},
    {"title": "G6PD", "detail": "No"},
    {"title": "Abnormal liver and liver disease", "detail": "No"},
    {"title": "Abnormal kidney and kidney disease", "detail": "No"},
    {"title": "Abnormal gastritis and gastritis disease", "detail": "No"},
    {"title": "Breastfeeding", "detail": "No"},
    {"title": "Pragnancy begin", "detail": "No"}
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kSizeS, vertical: kSizeS),
      child: SingleChildScrollView(
        child: Column(
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
                  print("Edit General Information");
                })
              ],
            ),
            ...data
                .map((e) => DetailTile(
                    title: e["title"].toString(),
                    detail: e["detail"].toString()))
                .toList()
          ],
        ),
      ),
    );
  }
}
