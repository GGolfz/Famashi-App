import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/screen/AuthScreen.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:famashi/widget/utils/form/customTextField.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/button.dart';
import 'package:niku/widget/text.dart';

class AuthForm extends StatelessWidget {
  final AuthType authType;
  final Function changeType;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  AuthForm({required this.authType, required this.changeType});
  String? _getTitle() {
    return {AuthType.Register: "Sign Up", AuthType.SignIn: "Log In"}[authType];
  }

  Widget _getChangeType() {
    var data = {
      AuthType.Register: {
        "text": "Already have an account?",
        "changeText": "Log in",
        "authType": AuthType.SignIn
      },
      AuthType.SignIn: {
        "text": "Don't have any account?",
        "changeText": "Sign up",
        "authType": AuthType.Register
      }
    };
    return NikuRow([
      NikuText(data[authType]!["text"].toString())
          .style(kBody05)
          .color(kNeutral03),
      kSizedBoxHorizontalXXS,
      Niku(NikuText(data[authType]!["changeText"].toString())
              .style(kBody05SemiBold)
              .color(kAccentColor01))
          .on(tap: () {
        changeType(data[authType]!["authType"]);
      })
    ]).mainCenter();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kBorderRadiusS,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kSizeM),
        child: Column(
          children: [
            kSizedBoxVerticalM,
            NikuText(_getTitle().toString()).style(kBody01Semibold),
            kSizedBoxVerticalS,
            CustomTextField(
              controller: _email,
              hintText: 'email',
              prefixIcon: Iconly.message,
            ),
            kSizedBoxVerticalS,
            CustomTextField(
              controller: _password,
              hintText: 'password',
              prefixIcon: Iconly.lock,
              isPassword: true,
            ),
            if (authType == AuthType.Register) ...[
              kSizedBoxVerticalS,
              CustomTextField(
                controller: _confirmPassword,
                hintText: 'confirm password',
                prefixIcon: Iconly.lock,
                isPassword: true,
              ),
            ],
            if (authType == AuthType.SignIn) ...[
              kSizedBoxVerticalS,
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                NikuText("Forget password?").style(kBody05).color(kNeutral03)
              ])
            ],
            kSizedBoxVerticalM,
            PrimaryButton(
              text: _getTitle()!,
              onPressed: () {},
            ),
            kSizedBoxVerticalS,
            _getChangeType(),
          ],
        ),
        width: double.infinity,
        color: kNeutralWhite,
      ),
    );
  }
}
