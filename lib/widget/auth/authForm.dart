import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/screen/AuthScreen.dart';
import 'package:famashi/widget/utils/form/customTextField.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/button.dart';
import 'package:niku/widget/text.dart';

class AuthForm extends StatelessWidget {
  final AuthType authType;
  final Function changeType;
  final TextEditingController _controller = TextEditingController();
  AuthForm({required this.authType, required this.changeType});
  String? _getTitle() {
    return {AuthType.Register: "Sign Up", AuthType.SignIn: "Log In"}[authType];
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kBorderRadiusS,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kSizeM),
        child: Column(
          children: [
            kSizedBoxVerticalS,
            NikuText(_getTitle().toString()).style(kBody01Semibold),
            kSizedBoxVerticalS,
            CustomTextField(
              controller: _controller,
              hintText: 'email',
              prefixIcon: Iconly.message,
            ),
            kSizedBoxVerticalS,
            CustomTextField(
              controller: _controller,
              hintText: 'password',
              prefixIcon: Iconly.lock,
              isPassword: true,
            ),
            NikuButton.elevated(
              NikuText("Login"),
            ).onPressed(() {
              var type = {
                AuthType.Register: AuthType.SignIn,
                AuthType.SignIn: AuthType.Register
              };
              changeType(type[authType]);
            })
          ],
        ),
        width: double.infinity,
        color: kNeutralWhite,
      ),
    );
  }
}
