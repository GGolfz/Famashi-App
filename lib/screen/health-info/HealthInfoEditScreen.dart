import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/medicalProvider.dart';
import 'package:famashi/provider/userProvider.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/customDivider.dart';
import 'package:famashi/widget/utils/form/customDatePicker.dart';
import 'package:famashi/widget/utils/form/customSelector.dart';
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
  String _gender = 'Male';

  DateTime _birthdate = DateTime.now();

  final _weight = TextEditingController.fromValue(TextEditingValue(text: "0"));

  final _height = TextEditingController.fromValue(TextEditingValue(text: "0"));

  String _g6pd = "No";

  String _liver = "No";

  String _kidney = "No";

  String _gastritis = "No";

  String _breastfeeding = "No";

  String _pregnant = "No";

  List<Widget> _buildForm() {
    return [
      ..._buildTextFieldGroup(
          "Gender",
          CustomSelector(
            current: _gender,
            items: ["Male", "Female"],
            onChange: (val) {
              setState(() {
                _gender = val;
              });
            },
          )),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
        "Birthdate",
        CustomDatePicker(
            current: _birthdate,
            onChange: (val) {
              setState(() {
                _birthdate = val;
              });
            }),
      ),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "Weight (kg)",
          CustomTextField(
            controller: _weight,
            name: "Weight",
            inputType: TextInputType.numberWithOptions(decimal: true),
          )),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "Height (cm)",
          CustomTextField(
            controller: _height,
            name: "Height",
            inputType: TextInputType.numberWithOptions(decimal: true),
          )),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "G6PD",
          CustomSelector(
            current: _g6pd,
            items: ["Yes", "No"],
            onChange: (val) {
              setState(() {
                _g6pd = val;
              });
            },
          )),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "Abnormal liver and liver disease",
          CustomSelector(
            current: _liver,
            items: ["Yes", "No"],
            onChange: (val) {
              setState(() {
                _liver = val;
              });
            },
          )),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "Abnormal kidney and kidney disease",
          CustomSelector(
            current: _kidney,
            items: ["Yes", "No"],
            onChange: (val) {
              setState(() {
                _kidney = val;
              });
            },
          )),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "Abnormal gastritis and gastritis disease",
          CustomSelector(
            current: _gastritis,
            items: ["Yes", "No"],
            onChange: (val) {
              setState(() {
                _gastritis = val;
              });
            },
          )),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "Breastfeeding",
          CustomSelector(
            current: _breastfeeding,
            items: ["Yes", "No"],
            onChange: (val) {
              setState(() {
                _breastfeeding = val;
              });
            },
          )),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup(
          "Pregnancy begin",
          CustomSelector(
            current: _pregnant,
            items: ["Yes", "No"],
            onChange: (val) {
              setState(() {
                _pregnant = val;
              });
            },
          )),
      kSizedBoxVerticalXS,
    ];
  }

  List<Widget> _buildTextFieldGroup(String text, Widget widget) {
    return [
      NikuText(text).style(kBody03Semibold).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      widget
    ];
  }

  Future<void> save(BuildContext context) async {
    await Provider.of<MedicalProvider>(context, listen: false)
        .updateMedicalInfo(_gender, _birthdate, _weight.text, _height.text,
            _g6pd, _liver, _kidney, _gastritis, _breastfeeding, _pregnant);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final provider = Provider.of<MedicalProvider>(context, listen: false);
    await provider.fetchMeidcalInfo();
    MedicalInfo data = provider.medicalInfo!;
    setState(() {
      _gender = data.genderString!;
      _birthdate = data.birthdate!;
      _weight.text = data.weight.toString();
      _height.text = data.height.toString();
      _g6pd = data.getBoolString(data.isG6PD!);
      _liver = data.getBoolString(data.isLiver!);
      _kidney = data.getBoolString(data.isKidney!);
      _gastritis = data.getBoolString(data.isGastritis!);
      _breastfeeding = data.getBoolString(data.isBreastfeeding!);
      _pregnant = data.getBoolString(data.isPregnant!);
    });
  }

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
