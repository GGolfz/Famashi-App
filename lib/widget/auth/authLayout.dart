import 'package:famashi/config/constant.dart';
import 'package:famashi/screen/AuthScreen.dart';
import 'package:famashi/widget/auth/authForm.dart';
import 'package:famashi/widget/auth/introductionText.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';

class AuthLayout extends StatelessWidget {
  final AuthType authType;
  final Function changeType;
  AuthLayout({required this.authType, required this.changeType});
  Widget getSpace() {
    return authType == AuthType.LogIn ? kSizedBoxVerticalM : kSizedBoxVerticalS;
  }

  @override
  Widget build(BuildContext context) {
    return Niku(
      SingleChildScrollView(
          reverse: true,
          child: NikuColumn(
            [
              AuthForm(
                changeType: changeType,
                authType: authType,
              )
            ],
          )),
    ).height(double.infinity).margin(EdgeInsets.all(kSizeS));
  }
}
