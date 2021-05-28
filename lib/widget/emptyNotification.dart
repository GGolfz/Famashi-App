import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class EmptyNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Niku(Center(
      child: NikuColumn([
        kSizedBoxVerticalS,
        Niku(
          Image(image: AssetImage('assets/images/no-notification.png')),
        ),
        kSizedBoxVerticalS,
        NikuText("Your notification haven’t been created").style(kBody05),
        kSizedBoxVerticalXXS,
        NikuText("Please,  go to “My medication” to create").style(kBody05),
        kSizedBoxVerticalXXS,
        NikuText("your notification").style(kBody05),
        kSizedBoxVerticalXXS,
      ]).crossCenter(),
    ));
  }
}
