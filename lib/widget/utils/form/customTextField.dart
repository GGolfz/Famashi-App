import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/textField.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String name;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? isPassword;
  final TextEditingController? compare;
  final TextInputType inputType;
  CustomTextField(
      {required this.controller,
      required this.name,
      this.hintText = '',
      this.prefixIcon,
      this.suffixIcon,
      this.isPassword = false,
      this.compare,
      this.inputType = TextInputType.text});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var showPassword = false;
  Widget _buildCustomTextField() {
    NikuTextField baseTextField = NikuTextField()
        .controller(widget.controller)
        .outlined(color: kNeutral06, borderRadius: kBorderRadiusS)
        .keyboardType(widget.inputType)
        .filled()
        .fillColor(kNeutral06)
        .hintText(widget.hintText)
        .hintStyle(kBody04Medium.copyWith(color: kNeutral03))
        .textStyle(kBody04Medium.copyWith(color: kNeutral02))
        .errorStyle(kBody04Medium.copyWith(color: kStateErrorBG))
        .floatingLabelBehavior(FloatingLabelBehavior.always)
        .focusColor(kAccentColor03)
        .errorBorder(OutlineInputBorder(
            borderSide: BorderSide(color: kNeutral06),
            borderRadius: kBorderRadiusS))
        .focusedErrorBorder(OutlineInputBorder(
            borderSide: BorderSide(color: kNeutral06),
            borderRadius: kBorderRadiusS))
        .validator((value) {
      if (value == '') {
        return '${widget.name} is required';
      }
      if (widget.name == 'Email') {
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value!)) {
          return 'Email is invalid';
        }
      }
      if (widget.isPassword! &&
          widget.compare != null &&
          value != widget.compare!.text) {
        return 'Confirm password must same as password';
      }
    });
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
