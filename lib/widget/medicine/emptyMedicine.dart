import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class EmptyMedicine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Niku(Center(
      child: NikuColumn([
        kSizedBoxVerticalS,
        Niku(
          Image(image: AssetImage('assets/images/no-medicine.png')),
        ),
        kSizedBoxVerticalXS,
        NikuText("It looks like you don't have any medical.").style(kBody05),
        kSizedBoxVerticalXXS,
        NikuText("press the add button below to add").style(kBody05),
        kSizedBoxVerticalXXS,
        NikuText("your first medicine.").style(kBody05),
      ]).crossCenter(),
    ));
  }
}
