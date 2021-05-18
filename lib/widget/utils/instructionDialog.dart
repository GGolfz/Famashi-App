import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class InstructionDialog extends StatelessWidget {
  final data = [
    "1. If it is almost time for the next dose, skip the missed dose and take the next dose when it is due.",
    "2. If you miss before meal pills, you could take a dose 2 hours after the meal on an empty stomach. (In general, you should take a before meal pill 30 minutes before meals)",
    "3. If you miss after meal pills, you could take a dose with a small meal. Don't take a dose on an empty stomach. (In general, you should take a after meal pill within 15 minutes after meals)",
    "4. For other special medications such as diabetes medications or hypertension medications, please consult with a doctor or pharmacist."
  ];
  List<Widget> _buildInstructionItem(String text) {
    return [
      kSizedBoxVerticalS,
      NikuText(text).style(kBody04).fontSize(15),
    ];
  }

  List<Widget> _buildInstructionList() {
    return [
      ..._buildInstructionItem(data[0]),
      ..._buildInstructionItem(data[1]),
      ..._buildInstructionItem(data[2]),
      ..._buildInstructionItem(data[3]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Niku(NikuColumn([
        Niku(Icon(
          Iconly.close_square,
          color: kNeutral02,
          size: kSizeS * 1.75,
        )).align(Alignment.centerRight).on(tap: () {
          Navigator.of(context).pop();
        }),
        NikuText("Instruction").style(kBody01Semibold).color(kNeutral01),
        kSizedBoxVerticalXS,
        NikuText("(If you have missed a dose, please do as following)")
            .style(kBody05Medium),
        ..._buildInstructionList(),
        kSizedBoxVerticalM,
        PrimaryButton(
            text: "Ok",
            onPressed: () {
              Navigator.of(context).pop();
            })
      ]).crossStart())
          .height(580)
          .padding(EdgeInsets.all(kSizeS * 1.5)),
    );
  }
}
