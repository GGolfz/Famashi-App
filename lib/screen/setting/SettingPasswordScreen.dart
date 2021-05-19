import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/userProvider.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/customDivider.dart';
import 'package:famashi/widget/utils/form/customTextField.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class SettingPasswordScreen extends StatelessWidget {
  static String routeName = '/setting-password';
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _confirmNewPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<Widget> _buildForm() {
    return [
      ..._buildTextFieldGroup("Current password", _currentPassword, null),
      kSizedBoxVerticalXS,
      CustomDivider(),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("New password", _newPassword, null),
      kSizedBoxVerticalXS,
      CustomDivider(),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "Confirm new password", _confirmNewPassword, _newPassword),
    ];
  }

  List<Widget> _buildTextFieldGroup(String text,
      TextEditingController controller, TextEditingController? compare) {
    return [
      NikuText(text).style(kBody03Semibold).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      compare != null
          ? CustomTextField(
              controller: controller,
              name: text,
              hintText: text,
              isPassword: true,
              prefixIcon: Iconly.lock,
              compare: compare)
          : CustomTextField(
              controller: controller,
              name: text,
              hintText: text,
              isPassword: true,
              prefixIcon: Iconly.lock,
            )
    ];
  }

  Future<void> changePassword(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      String currentPassword = _currentPassword.text;
      String newPassword = _newPassword.text;
      String confirmNewPassword = _confirmNewPassword.text;
      if (newPassword == confirmNewPassword) {
        Provider.of<UserProvider>(context, listen: false)
            .changePassword(currentPassword, newPassword);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
      child: Niku(Form(
              key: _formKey,
              child: NikuColumn([
                Expanded(child: NikuColumn(_buildForm()).crossStart()),
                PrimaryButton(
                    text: "Save", onPressed: () => changePassword(context))
              ])))
          .padding(EdgeInsets.only(
              top: kSizeS, bottom: kSizeM, left: kSizeM, right: kSizeM)),
      title: 'Password Setting',
      isHome: false,
    );
  }
}
