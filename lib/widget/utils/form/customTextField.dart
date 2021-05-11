import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/textField.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? isPassword;
  CustomTextField(
      {required this.controller,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.isPassword = false});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var showPassword = false;
  Widget _buildCustomTextField() {
    NikuTextField baseTextField = NikuTextField()
        .controller(widget.controller)
        .outlined(color: kNeutral06, borderRadius: kBorderRadiusS)
        .bg(kNeutral06)
        .filled()
        .hintText(widget.hintText)
        .hintStyle(kBody04Medium.copyWith(color: kNeutral03))
        .textStyle(kBody04Medium.copyWith(color: kNeutral02))
        .floatingLabelBehavior(FloatingLabelBehavior.always)
        .focusColor(kAccentColor03);
    if (widget.prefixIcon != null) {
      baseTextField = baseTextField.prefixIcon(Icon(
        widget.prefixIcon,
        color: kPrimaryColor04,
      ));
    }
    if (widget.isPassword == true) {
      baseTextField = baseTextField
          .suffix(GestureDetector(
            child: Icon(
              showPassword ? Iconly.hide : Iconly.show,
              color: kNeutral03,
            ),
            onTap: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ))
          .obscureText(!showPassword);
    } else {
      if (widget.suffixIcon != null) {
        baseTextField = baseTextField.suffixIcon(Icon(widget.suffixIcon));
      }
    }
    return baseTextField;
  }

  @override
  Widget build(BuildContext context) {
    return _buildCustomTextField();
  }
}