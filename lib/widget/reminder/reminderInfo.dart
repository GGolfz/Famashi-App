import 'package:famashi/config/color.dart';
import 'package:famashi/provider/notificationProvider.dart';
import 'package:flutter/material.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/button.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class ReminderInfo extends StatefulWidget {
  final int reminderID;
  final String? medicineImage;
  final String medicineName;
  final int dosageAmount;
  final String medicineUnit;
  ReminderInfo(
      {required this.reminderID,
      required this.medicineImage,
      required this.medicineName,
      required this.dosageAmount,
      required this.medicineUnit});

  @override
  State<ReminderInfo> createState() => _ReminderInfoState();
}

class _ReminderInfoState extends State<ReminderInfo> {
  var onTap = false;

  void tap() {
    setState(() {
      onTap = !onTap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key(widget.reminderID.toString()),
      padding: const EdgeInsets.all(15),
      child: Container(
        color: kNeutralWhite,
        height: 260,
        width: 149,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            onTap
                ? Stack(
                    children: [
                      Container(
                          foregroundDecoration: BoxDecoration(
                            color: kNeutral06,
                            backgroundBlendMode: BlendMode.saturation,
                          ),
                          child: MedicineImage(
                              medicineImage: widget.medicineImage)),
                      Positioned.fill(
                          child: Niku(NikuColumn([
                        NikuText("Already used?")
                            .style(kBody04Medium)
                            .color(kNeutralWhite),
                        NikuRow([
                          NikuButton(NikuText("No")
                                  .style(kBody05)
                                  .color(kNeutralWhite))
                              .onPressed(() {
                            tap();
                          }),
                          NikuButton(NikuText("Yes")
                                  .style(kBody05)
                                  .color(kNeutralWhite))
                              .onPressed(() async {
                            await Provider.of<NotificationProvider>(context,
                                    listen: false)
                                .takeMedicine(widget.reminderID);
                          })
                        ]).mainCenter()
                      ]).mainEnd()))
                    ],
                  )
                : GestureDetector(
                    onTap: () {
                      tap();
                    },
                    child: MedicineImage(
                      medicineImage: widget.medicineImage,
                    )),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                widget.medicineName,
                style: kBody04Medium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 1.0),
              child: Text(
                'Amount ${widget.dosageAmount} ${widget.medicineUnit}',
                style: kBody05,
              ),
            )
          ],
        ),
      ),
    );
  }
}
