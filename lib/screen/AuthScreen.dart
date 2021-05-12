import 'package:famashi/widget/auth/authLayout.dart';
import 'package:flutter/material.dart';

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
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          child: kBackgroundImage,
        ),
        AuthLayout(
            authType: authType,
            changeType: (type) {
              setState(() {
                authType = type;
              });
            })
      ],
    ));
  }
}
