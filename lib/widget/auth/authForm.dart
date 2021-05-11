import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/screen/AuthScreen.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:famashi/widget/utils/form/customTextField.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/button.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

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

  final _formKey = GlobalKey<FormState>();

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

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String email = _email.text;
      String password = _password.text;
      if (authType == AuthType.Register) {
        String confirmPassword = _confirmPassword.text;
        if (password == confirmPassword) {
          await Provider.of<AuthenticateProvider>(context, listen: false)
              .register(email, password);
        }
      } else if (authType == AuthType.SignIn) {
        await Provider.of<AuthenticateProvider>(context, listen: false)
            .login(email, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kBorderRadiusS,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kSizeM),
        child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    kSizedBoxVerticalM,
                    NikuText(_getTitle().toString()).style(kBody01Semibold),
                    kSizedBoxVerticalS,
                    CustomTextField(
                      controller: _email,
                      hintText: 'email',
                      name: 'Email',
                      prefixIcon: Iconly.message,
                    ),
                    kSizedBoxVerticalS,
                    CustomTextField(
                      controller: _password,
                      hintText: 'password',
                      name: 'Password',
                      prefixIcon: Iconly.lock,
                      isPassword: true,
                    ),
                    if (authType == AuthType.Register) ...[
                      kSizedBoxVerticalS,
                      CustomTextField(
                          controller: _confirmPassword,
                          name: 'Confirm password',
                          hintText: 'confirm password',
                          prefixIcon: Iconly.lock,
                          isPassword: true,
                          compare: _password.text),
                    ],
                    if (authType == AuthType.SignIn) ...[
                      kSizedBoxVerticalS,
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        NikuText("Forget password?")
                            .style(kBody05)
                            .color(kNeutral03)
                      ])
                    ],
                    kSizedBoxVerticalM,
                    PrimaryButton(
                      text: _getTitle()!,
                      onPressed: () => _submitForm(context),
                    ),
                    kSizedBoxVerticalS,
                    _getChangeType(),
                    kSizedBoxVerticalS,
                  ],
                ))),
        width: double.infinity,
        color: kNeutralWhite,
      ),
    );
  }
}
