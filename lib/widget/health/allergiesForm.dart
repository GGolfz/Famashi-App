import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/allergiesProvider.dart';
import 'package:famashi/provider/medicalProvider.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:famashi/widget/utils/form/customTextField.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class AllergiesForm extends StatelessWidget {
  final _medicineName = TextEditingController();
  final _sideEffect = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Niku(NikuColumn([
      NikuText("Add Allergies").style(kBody01Semibold),
      kSizedBoxVerticalS,
      NikuText("Allergy medicine name")
          .style(kBody04Medium)
          .color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      Form(
          key: _formKey,
          child: CustomTextField(
            controller: _medicineName,
            name: 'Medicine name',
            hintText: 'allergy medicine name',
          )),
      kSizedBoxVerticalS,
      NikuText("Side effect").style(kBody04Medium).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      CustomTextField(
        controller: _sideEffect,
        name: 'side effect',
        hintText: 'side effect',
      ),
      kSizedBoxVerticalS,
      PrimaryButton(
        text: "Save",
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            try {
              await Provider.of<AllergiesProvider>(context, listen: false)
                  .createAllergy(_medicineName.text, _sideEffect.text);
              Navigator.of(context).pop();
            } on ErrorResponse catch (error) {
              showDialog(
                  context: context,
                  builder: (ctx) => ErrorDialog(error: error.toString()));
            }
          }
        },
      )
    ]).crossStart())
        .padding(EdgeInsets.all(kSizeM))
        .height(kSizeXXL * 1.76);
  }
}
