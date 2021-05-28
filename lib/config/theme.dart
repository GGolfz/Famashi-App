import 'package:famashi/config/color.dart';
import 'package:famashi/config/style.dart';
import 'package:flutter/material.dart';

final famashiTheme = _buildMainTheme();
ThemeData _buildMainTheme() {
  final baseTheme = ThemeData.light();
  return baseTheme.copyWith(
      accentColor: kAccentColor01,
      primaryColor: kPrimaryColor01,
      buttonTheme: baseTheme.buttonTheme.copyWith(
          buttonColor: kPrimaryColor04,
          colorScheme:
              baseTheme.colorScheme.copyWith(secondary: kAccentColor03)),
      scaffoldBackgroundColor: kNeutralWhite,
      textTheme: baseTheme.textTheme
          .copyWith(
            headline1: kBody01Semibold,
            headline2: kBody02Semibold,
          )
          .apply(fontFamily: kMontserratFont),
      primaryIconTheme: baseTheme.iconTheme.copyWith(color: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(), focusColor: kAccentColor04),
      colorScheme: ColorScheme.light().copyWith(primary: kPrimaryColor04));
}
