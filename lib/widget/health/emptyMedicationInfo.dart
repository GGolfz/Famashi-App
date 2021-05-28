import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class EmptyMedicationInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Niku(Center(
      child: NikuColumn([
        kSizedBoxVerticalS,
        Niku(
          Image(image: AssetImage('assets/images/no-history.png')),
        ),
        kSizedBoxVerticalS,
        NikuText("Your medication haven’t been created.").style(kBody05),
        kSizedBoxVerticalXXS,
      ]).crossCenter(),
    ));
  }
}
