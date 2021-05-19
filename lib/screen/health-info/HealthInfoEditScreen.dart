import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/userProvider.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/customDivider.dart';
import 'package:famashi/widget/utils/form/customDatePicker.dart';
import 'package:famashi/widget/utils/form/customTextField.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class HealthInfoEditScreen extends StatefulWidget {
  static String routeName = '/healthinfo-edit';

  @override
  _HealthInfoEditScreenState createState() => _HealthInfoEditScreenState();
}

class _HealthInfoEditScreenState extends State<HealthInfoEditScreen> {
  final _gender = TextEditingController();

  DateTime _birthdate = DateTime.now();

  final _weight = TextEditingController();

  final _height = TextEditingController();

  final _g6pd = TextEditingController();

  final _liver = TextEditingController();

  final _kidney = TextEditingController();

  final _gastritis = TextEditingController();

  final _breastfeeding = TextEditingController();

  final _pregnant = TextEditingController();

  List<Widget> _buildForm() {
    return [
      ..._buildTextFieldGroup("Gender", _gender, "gender"),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("Birthdate", _birthdate, "date"),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("Weight", _weight, "number"),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("Height", _height, "number"),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("G6PD", _g6pd, "select"),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "Abnormal liver and liver disease", _liver, "select"),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "Abnormal kidney and kidney disease", _kidney, "select"),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "Abnormal gastritis and gastritis disease", _gastritis, "select"),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("Breastfeeding", _breastfeeding, "select"),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("Pregnancy begin", _pregnant, "select"),
      kSizedBoxVerticalXS,
    ];
  }

  List<Widget> _buildTextFieldGroup(String text, controller, String type) {
    return [
      NikuText(text).style(kBody03Semibold).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      if (type == "date")
        CustomDatePicker(
            current: controller,
            onChange: (val) {
              setState(() {
                _birthdate = val;
              });
            })
    ];
  }

  Future<void> save(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
      child: Niku(NikuColumn([
        Expanded(
            child: SingleChildScrollView(
                child: NikuColumn(_buildForm()).crossStart())),
        PrimaryButton(text: "Save", onPressed: () => save(context))
      ])).padding(EdgeInsets.only(
          top: kSizeS, bottom: kSizeM, left: kSizeM, right: kSizeM)),
      title: 'Edit Information',
      isHome: false,
    );
  }
}
