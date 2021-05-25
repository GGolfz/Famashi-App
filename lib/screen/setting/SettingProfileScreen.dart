import 'package:dio/dio.dart';
import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/userProvider.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/user/profile_img_selector.dart';
import 'package:famashi/widget/utils/customDivider.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:famashi/widget/utils/form/customTextField.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class SettingProfileScreen extends StatelessWidget {
  static String routeName = '/setting-profile';
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();

  var uploadedFile;

  List<Widget> _buildForm() {
    return [
      ..._buildTextFieldGroup("Email", _email),
      kSizedBoxVerticalXS,
      CustomDivider(),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("First name", _firstname),
      kSizedBoxVerticalXS,
      CustomDivider(),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("Last name", _lastname),
    ];
  }

  List<Widget> _buildTextFieldGroup(
      String text, TextEditingController controller) {
    return [
      NikuText(text).style(kBody04Medium).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      CustomTextField(
        controller: controller,
        name: text,
        hintText: text,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).fetchUser();
    return TemplateLayout(
      child: Consumer<UserProvider>(builder: (ctx, user, _) {
        _email.text = user.user!.email!;
        _firstname.text = user.user!.firstname!;
        _lastname.text = user.user!.lastname!;
        return Niku(Form(
                key: _formKey,
                child: NikuColumn([
                  Expanded(
                      child: NikuColumn([
                    ProfileImageSelector(
                        img: user.user!.img,
                        onUpload: (file) async {
                          uploadedFile =
                              await MultipartFile.fromFile(file.path);
                        }),
                    kSizedBoxVerticalS,
                    ..._buildForm()
                  ]).crossStart()),
                  PrimaryButton(
                      text: "Save",
                      onPressed: () async {
                        try {
                          await Provider.of<UserProvider>(context,
                                  listen: false)
                              .updateProfile(_email.text, _firstname.text,
                                  _lastname.text, uploadedFile);
                        } on ErrorResponse catch (error) {
                          if (error.toString() == "Unauthorize") {
                            Provider.of<AuthenticateProvider>(context,
                                    listen: false)
                                .logout();
                          } else {
                            showDialog(
                                context: context,
                                builder: (ctx) =>
                                    ErrorDialog(error: error.toString()));
                          }
                        }
                      })
                ])))
            .padding(EdgeInsets.only(
                top: kSizeS, bottom: kSizeM, left: kSizeM, right: kSizeM));
      }),
      title: 'Profile Setting',
      isHome: false,
    );
  }
}
