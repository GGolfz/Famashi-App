import 'package:famashi/config/constant.dart';
import 'package:famashi/widget/auth/authLayout.dart';
import 'package:famashi/widget/auth/introductionText.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';

enum AuthType { SignUp, LogIn }

class AuthScreen extends StatefulWidget {
  static String routeName = '/auth';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var authType;
  @override
  void initState() {
    authType = AuthType.LogIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kBackgroundImage = Image.asset('assets/images/authenticate-bg.png');
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Niku(kBackgroundImage)
                .height(double.infinity)
                .width(double.infinity),
            Niku(NikuColumn(
              [
                kSizedBoxVerticalXXL,
                IntroductionText(
                  authType: authType,
                ),
              ],
            )).height(double.infinity).padding(EdgeInsets.all(kSizeS)),
            Scaffold(
                backgroundColor: Colors.transparent,
                body: AuthLayout(
                    authType: authType,
                    changeType: (type) {
                      setState(() {
                        authType = type;
                      });
                    }))
          ],
        ));
  }
}
