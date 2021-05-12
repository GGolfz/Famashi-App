import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/health/detailTile.dart';
import 'package:famashi/widget/utils/customDiver.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class AllergiesInfo extends StatelessWidget {
  final List<Map<String, String>> data = [
    {
      "title": "Dapsone allergies",
      "detail": "congestion, runny nose, and swollen eyes. "
    },
    {
      "title": "Carbamazepine allergies",
      "detail":
          "breathing difficulties, lightheadedness, and loss of consciousness. "
    },
    {
      "title": "Amoxicillin allergies",
      "detail": "trigger swelling, hives, nausea, fatigue, and more."
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kSizeS, vertical: kSizeXXS),
      child: ListView.separated(
        itemBuilder: (ctx, index) => DetailTile(
          title: data[index]["title"].toString(),
          detail: data[index]["detail"].toString(),
          big: true,
        ),
        separatorBuilder: (context, index) => CustomDivider(),
        itemCount: data.length,
      ),
    );
  }
}
