import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/text.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;
  final bool isDisabled;
  PrimaryButton(
      {required this.text,
      required this.onPressed,
      this.isLoading = false,
      this.isDisabled = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: kSizeS),
        child: Material(
          type: MaterialType.transparency,
          child: Ink(
            width: double.infinity,
            decoration: _buildBoxDecoration(context),
            child: _buildContent(context),
          ),
        ));
  }

  Widget _buildContent(BuildContext context) {
    return InkWell(
      borderRadius: kBorderRadiusM,
      onTap: () {
        if (!isLoading && !isDisabled) {
          onPressed();
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kSizeXS * 1.25,
          horizontal: kSizeM,
        ),
        child: isLoading
            ? SizedBox(
                height: 25,
                child: FittedBox(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            : NikuText(text)
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
