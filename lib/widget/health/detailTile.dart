import 'package:famashi/config/color.dart';
import 'package:famashi/config/style.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/text.dart';

class DetailTile extends StatelessWidget {
  final String title;
  final String detail;
  final bool big;
  DetailTile({required this.title, required this.detail, this.big = false});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NikuText(title)
          .style(big ? kBody02Semibold : kBody04SemiBold)
          .color(kPrimaryColor05),
      subtitle: NikuText(detail).style(kBody05).color(kNeutral02),
      contentPadding: EdgeInsets.zero,
    );
  }
}
