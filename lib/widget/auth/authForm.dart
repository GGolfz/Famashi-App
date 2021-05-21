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
import 'package:niku/widget/iconButton.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  final AuthType authType;
  final Function changeType;

  AuthForm({required this.authType, required this.changeType});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _firstname = TextEditingController();

  final TextEditingController _lastname = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _confirmPassword = TextEditingController();

  var _page = 0;

  String? _getTitle() {
    return {
      AuthType.SignUp: "Sign Up",
      AuthType.LogIn: "Log In"
    }[widget.authType];
  }

  String? _getButtonTitle() {
    return _page == getForm()[widget.authType]!.length - 1
        ? _getTitle()
        : "Next";
  }

  final _formKey = GlobalKey<FormState>();

  Widget _getChangeType() {
    var data = {
      AuthType.SignUp: {
        "text": "Already have an account?",
        "changeText": "Log in",
        "authType": AuthType.LogIn
      },
      AuthType.LogIn: {
        "text": "Don't have any account?",
        "changeText": "Sign up",
        "authType": AuthType.SignUp
      }
    };
    return NikuRow([
      NikuText(data[widget.authType]!["text"].toString())
          .style(kBody05)
          .color(kNeutral03),
      kSizedBoxHorizontalXXS,
      Niku(NikuText(data[widget.authType]!["changeText"].toString())
              .style(kBody05SemiBold)
              .color(kAccentColor01))
          .on(tap: () {
        _formKey.currentState!.reset();
        setState(() {
          _page = 0;
        });
        widget.changeType(data[widget.authType]!["authType"]);
      })
    ]).mainCenter();
  }

  Map<AuthType, List<List<Widget>>> getForm() {
    List<Widget> baseForm = [
      kSizedBoxVerticalM,
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
    ];
    return {
      AuthType.LogIn: [
        [
          ...baseForm,
          kSizedBoxVerticalS,
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            NikuText("Forget password?").style(kBody05).color(kNeutral03)
          ])
        ]
      ],
      AuthType.SignUp: [
        [
          ...baseForm,
          kSizedBoxVerticalS,
          CustomTextField(
              controller: _confirmPassword,
              name: 'Confirm password',
              hintText: 'confirm password',
              prefixIcon: Iconly.lock,
              isPassword: true,
              compare: _password),
        ],
        [
          kSizedBoxVerticalM,
          CustomTextField(
            controller: _firstname,
            hintText: 'first name',
            name: 'First name',
          ),
          kSizedBoxVerticalS,
          CustomTextField(
            controller: _lastname,
            hintText: 'last name',
            name: 'Last name',
          ),
          kSizedBoxVerticalM
        ]
      ]
    };
  }

  List<Widget> _getBackButton() {
    return _page > 0
        ? [
            SizedBox(
                width: 40,
                height: 20,
                child: NikuIconButton(Icon(Iconly.arrow_left)).onPressed(() {
                  String firstname = _firstname.text;
                  String lastname = _lastname.text;
                  _formKey.currentState!.reset();
                  _firstname.text = firstname;
                  _lastname.text = lastname;
                  setState(() {
                    _page -= 1;
                  });
                })),
          ]
        : [];
  }

  List<Widget> _getSizedBox() {
    return _page > 0
        ? [
            SizedBox(
              width: 40,
            )
          ]
        : [];
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (_page != getForm()[widget.authType]!.length - 1) {
        setState(() {
          _page += 1;
        });
      } else {
        String email = _email.text;
        String password = _password.text;
        if (widget.authType == AuthType.SignUp) {
          String confirmPassword = _confirmPassword.text;
          String firstName = _firstname.text;
          String lastName = _lastname.text;
          if (password == confirmPassword) {
            await Provider.of<AuthenticateProvider>(context, listen: false)
                .register(email, password, firstName, lastName);
          }
        } else if (widget.authType == AuthType.LogIn) {
          await Provider.of<AuthenticateProvider>(context, listen: false)
              .login(email, password);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: kBorderRadiusS,
      child: Niku(
        SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: NikuColumn(
                  [
                    kSizedBoxVerticalM,
                    NikuRow([
                      ..._getBackButton(),
                      NikuText(_getTitle().toString()).style(kBody01Semibold),
                      ..._getSizedBox(),
                    ])
                        .mainAxisAlignment(_page == 0
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceBetween)
                        .crossCenter(),
                    ...getForm()[widget.authType]![_page],
                    kSizedBoxVerticalM,
                    PrimaryButton(
                      text: _getButtonTitle()!,
                      onPressed: () => _submitForm(context),
                    ),
                    kSizedBoxVerticalS,
                    _getChangeType(),
                    kSizedBoxVerticalS,
                  ],
                ))),
      )
          .padding(EdgeInsets.symmetric(horizontal: kSizeM))
          .width(double.infinity)
          .backgroundColor(kNeutralWhite),
    );
  }
}
