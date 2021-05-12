import 'package:famashi/config/constant.dart';
import 'package:famashi/widget/health/detailTile.dart';
import 'package:famashi/widget/utils/customDiver.dart';
import 'package:flutter/material.dart';

class MedicationInfo extends StatelessWidget {
  final List<Map<String, String>> data = [
    {"title": "Brown Mixture 5 capsules", "detail": "12/05/2021 12:00"},
    {"title": "Brufen™ 1 capsule", "detail": "11/05/2021 18:00"},
    {"title": "Calcium 3 capsules", "detail": "10/05/2021 22:00"},
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
