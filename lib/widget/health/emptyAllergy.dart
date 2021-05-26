import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class EmptyAllergy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Niku(Center(
      child: NikuColumn([
        kSizedBoxVerticalS,
        Container(
          child: Image(image: AssetImage('assets/images/no-allergy.png')),
        ),
        kSizedBoxVerticalXS,
        NikuText(
                "Great! now you don’t have any allergies.")
            .style(kBody05.copyWith(color: kNeutralBlack)), 
        kSizedBoxVerticalXXS,
        NikuText(
                "But if you have, press the add button below")
           .style(kBody05.copyWith(color: kNeutralBlack)), 
        kSizedBoxVerticalXXS,
        NikuText(
                "to add your allergies.")
            .style(kBody05.copyWith(color: kNeutralBlack)), 
      ]).crossCenter(),
    ));
  }
}