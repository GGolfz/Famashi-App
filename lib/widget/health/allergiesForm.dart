import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/allergiesProvider.dart';
import 'package:famashi/provider/medicalProvider.dart';
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
  @override
  Widget build(BuildContext context) {
    return Niku(NikuColumn([
      NikuText("Add Allergies").style(kBody01Semibold),
      kSizedBoxVerticalS,
      NikuText("Allergy medicine name")
          .style(kBody04Medium)
          .color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      CustomTextField(
        controller: _medicineName,
        name: 'medicine name',
        hintText: 'allergy medicine name',
      ),
      kSizedBoxVerticalXS,
      NikuText("Side effect").style(kBody04Medium).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      CustomTextField(
        controller: _sideEffect,
        name: 'side effect',
        hintText: 'side effect',
      ),
      kSizedBoxVerticalS,
      Niku(PrimaryButton(
        text: "Save",
        onPressed: () async {
          await Provider.of<AllergiesProvider>(context, listen: false)
              .createAllergy(_medicineName.text, _sideEffect.text);
          Navigator.of(context).pop();
        },
      )).widthPercent(80).center()
    ]).crossStart())
        .padding(EdgeInsets.all(kSizeM))
        .height(kSizeXXL * 1.65);
  }
}
