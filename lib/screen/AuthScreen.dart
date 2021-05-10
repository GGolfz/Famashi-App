import 'package:flutter/material.dart';

enum AuthType { Register, SignIn }

class AuthScreen extends StatefulWidget {
  static String routeName = '/auth';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var authType;
  @override
  void initState() {
    authType = AuthType.Register;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: authType == AuthType.Register
            ? Text("Register Screen")
            : Text("Sign In Screen"),
      ),
    );
  }
}
