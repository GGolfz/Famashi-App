import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/text.dart';

class OkButton extends StatelessWidget {
  final Function onPressed;
  OkButton({
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        width: double.infinity,
        decoration: _buildBoxDecoration(context),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return InkWell(
      borderRadius: kBorderRadiusM,
      onTap: () {
        onPressed();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kSizeXS * 1.25,
          horizontal: kSizeM,
        ),
        child: NikuText("Ok")
            .style(kBody03Medium)
            .color(kNeutralWhite)
            .alignCenter(),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: kPrimaryColor04,
      borderRadius: kBorderRadiusM,
    );
  }
}
