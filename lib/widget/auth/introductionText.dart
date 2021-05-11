import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/screen/AuthScreen.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/text.dart';

class IntroductionText extends StatelessWidget {
  final AuthType? authType;
  IntroductionText({@required this.authType});
  final textList = <AuthType, Map<String, String>>{
    AuthType.SignIn: {
      "headline": "Welcome!",
      "body": "Please login to continue\nusing an application.",
    },
    AuthType.Register: {
      "headline": "Let get started !",
      "body": "Create new account.",
    }
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(kSizeS * 1.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NikuText(textList[authType]!["headline"].toString())
              .style(kHeading)
              .color(kNeutralWhite),
          kSizedBoxVerticalS,
          NikuText(textList[authType]!["body"].toString())
              .style(kBody02Light)
              .color(kNeutralWhite),
        ],
      ),
    );
  }
}
