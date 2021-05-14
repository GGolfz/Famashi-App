import 'package:famashi/provider/notificationProvider.dart';
import 'package:famashi/widget/utils/form/customTimePicker.dart';
import 'package:famashi/widget/utils/form/customTimePickerField.dart';
import 'package:flutter/material.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/utils/format.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
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

  @override
  Widget build(BuildContext context) {
    Provider.of<NotificationProvider>(context, listen: false)
        .fetchNotification();
    return TemplateLayout(
      child: Niku(Consumer<NotificationProvider>(builder: (ctx, notify, _) {
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
              _buildTimeTextField(_beforeMorning, context),
              _buildTimeTextField(_afterMorning, context),
              _buildTimeTextField(_beforeNoon, context),
              _buildTimeTextField(_afterNoon, context),
              _buildTimeTextField(_beforeEvening, context),
              _buildTimeTextField(_afterEvening, context),
              _buildTimeTextField(_bedtime, context),
              Expanded(child: NikuColumn([]).crossStart()),
              PrimaryButton(
                  text: "Save",
                  onPressed: () async {
                    await Provider.of<NotificationProvider>(context,
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
                  })
            ]));
      })).padding(EdgeInsets.only(
          top: kSizeS, bottom: kSizeM, left: kSizeM, right: kSizeM)),
      title: 'Notification Setting',
      isHome: false,
    );
  }
}
