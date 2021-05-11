import 'package:famashi/config/constant.dart';
import 'package:famashi/screen/AuthScreen.dart';
import 'package:famashi/widget/auth/authForm.dart';
import 'package:famashi/widget/auth/introductionText.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final AuthType authType;
  final Function changeType;
  AuthLayout({required this.authType, required this.changeType});
  Widget getSpace() {
    return authType == AuthType.SignIn
        ? kSizedBoxVerticalS
        : kSizedBoxVerticalM;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kSizeS),
      height: double.infinity,
      child: Column(
        children: [
          kSizedBoxVerticalXXL,
          IntroductionText(
            authType: authType,
          ),
          getSpace(),
          Expanded(
              child: AuthForm(
            changeType: changeType,
            authType: authType,
          ))
        ],
      ),
    );
  }
}
