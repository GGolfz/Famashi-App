import 'package:flutter/material.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:famashi/config/constant.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';

class SettingNotificationScreen extends StatelessWidget {
  static String routeName = '/setting-notification';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
      child: Niku(Form(
              key: _formKey,
              child: NikuColumn([
                Expanded(child: NikuColumn([]).crossStart()),
                PrimaryButton(text: "Save", onPressed: () {})
              ])))
          .padding(EdgeInsets.only(
              top: kSizeS, bottom: kSizeM, left: kSizeM, right: kSizeM)),
      title: 'Notification Setting',
      isHome: false,
    );
  }
}
