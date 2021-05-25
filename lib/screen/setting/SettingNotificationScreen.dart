import 'package:famashi/config/color.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/userNotificationProvider.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/utils/customDivider.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:famashi/widget/utils/form/customTimePicker.dart';
import 'package:famashi/widget/utils/form/customTimePickerField.dart';
import 'package:flutter/material.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/utils/format.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class SettingNotificationScreen extends StatelessWidget {
  static String routeName = '/setting-notification';
  final _formKey = GlobalKey<FormState>();
  final _beforeMorning =
      TextEditingController.fromValue(TextEditingValue(text: "07:00"));
  final _afterMorning =
      TextEditingController.fromValue(TextEditingValue(text: "08:00"));
  final _beforeNoon =
      TextEditingController.fromValue(TextEditingValue(text: "12:00"));
  final _afterNoon =
      TextEditingController.fromValue(TextEditingValue(text: "13:00"));
  final _beforeEvening =
      TextEditingController.fromValue(TextEditingValue(text: "17:00"));
  final _afterEvening =
      TextEditingController.fromValue(TextEditingValue(text: "18:00"));
  final _bedtime =
      TextEditingController.fromValue(TextEditingValue(text: "22:00"));

  Widget _buildTimeTextField(
      TextEditingController controller, BuildContext context) {
    return CustomTimePickerField(
        controller: controller,
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (ctx) => CustomTimePicker(
                    onSave: (Duration value) {
                      controller.text =
                          "${formatTime(value.inHours)}:${formatTime(value.inMinutes % 60)}";
                      Navigator.of(context).pop();
                    },
                    currentValue: Duration(
                        hours: int.parse(controller.text.split(':')[0]),
                        minutes: int.parse(controller.text.split(':')[1])),
                  ));
        });
  }

  List<Widget> _buildNotificationGroup(
      String title, Widget left, Widget right) {
    return [
      NikuText(title).style(kBody02Semibold).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      Row(children: [
        Expanded(flex: 5, child: left),
        kSizedBoxHorizontalS,
        Expanded(flex: 5, child: right)
      ])
    ];
  }

  Widget _buildTextFieldGroup(String title, Widget widget) {
    return Niku(NikuColumn([
      NikuText(title).style(kBody04Medium).color(kNeutral02),
      kSizedBoxVerticalXS,
      widget
    ]).crossStart());
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserNotificationProvider>(context, listen: false)
        .fetchNotification();
    return TemplateLayout(
      child: Niku(Consumer<UserNotificationProvider>(builder: (ctx, notify, _) {
        _beforeMorning.text = notify.notify!.beforeMorning;
        _afterMorning.text = notify.notify!.afterMorning;
        _beforeNoon.text = notify.notify!.beforeNoon;
        _afterNoon.text = notify.notify!.afterNoon;
        _beforeEvening.text = notify.notify!.beforeEvening;
        _afterEvening.text = notify.notify!.afterEvening;
        _bedtime.text = notify.notify!.bedtime;
        return Form(
            key: _formKey,
            child: NikuColumn([
              Expanded(
                  child: NikuColumn([
                ..._buildNotificationGroup(
                    'Morning Medicine',
                    _buildTextFieldGroup(
                      'Before Meal',
                      _buildTimeTextField(_beforeMorning, context),
                    ),
                    _buildTextFieldGroup(
                      'After Meal',
                      _buildTimeTextField(_afterMorning, context),
                    )),
                kSizedBoxVerticalS,
                CustomDivider(),
                kSizedBoxVerticalS,
                ..._buildNotificationGroup(
                    'Noon Medicine',
                    _buildTextFieldGroup(
                      'Before Meal',
                      _buildTimeTextField(_beforeNoon, context),
                    ),
                    _buildTextFieldGroup(
                      'After Meal',
                      _buildTimeTextField(_afterNoon, context),
                    )),
                kSizedBoxVerticalS,
                CustomDivider(),
                kSizedBoxVerticalS,
                ..._buildNotificationGroup(
                    'Evening Medicine',
                    _buildTextFieldGroup(
                      'Before Meal',
                      _buildTimeTextField(_beforeEvening, context),
                    ),
                    _buildTextFieldGroup(
                      'After Meal',
                      _buildTimeTextField(_afterEvening, context),
                    )),
                kSizedBoxVerticalS,
                CustomDivider(),
                kSizedBoxVerticalS,
                ..._buildNotificationGroup(
                    'Bedtime Medicine',
                    _buildTextFieldGroup(
                      'Bedtime',
                      _buildTimeTextField(_beforeEvening, context),
                    ),
                    Niku()),
              ]).crossStart()),
              PrimaryButton(
                  text: "Save",
                  onPressed: () async {
                    try {
                      await Provider.of<UserNotificationProvider>(context,
                              listen: false)
                          .editNotification({
                        "BEFORE_MORNING": _beforeMorning.text,
                        "AFTER_MORNING": _afterMorning.text,
                        "BEFORE_NOON": _beforeNoon.text,
                        "AFTER_NOON": _afterNoon.text,
                        "BEFORE_EVENING": _beforeEvening.text,
                        "AFTER_EVENING": _afterEvening.text,
                        "BEDTIME": _bedtime.text,
                      });
                    } on ErrorResponse catch (error) {
                      if (error.toString() == "Unauthorize") {
                        Provider.of<AuthenticateProvider>(context,
                                listen: false)
                            .logout();
                      } else {
                        showDialog(
                            context: context,
                            builder: (ctx) =>
                                ErrorDialog(error: error.toString()));
                      }
                    }
                  })
            ]));
      })).padding(EdgeInsets.only(
          top: kSizeS, bottom: kSizeM, left: kSizeM, right: kSizeM)),
      title: 'Notification Setting',
      isHome: false,
    );
  }
}
