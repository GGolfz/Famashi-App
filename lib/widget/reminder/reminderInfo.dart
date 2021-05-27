import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/notificationProvider.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/button.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class ReminderInfo extends StatelessWidget {
  final int reminderID;
  final int selectedID;
  final Function onSelect;
  final String? medicineImage;
  final String medicineName;
  final int dosageAmount;
  final String medicineUnit;
  ReminderInfo(
      {required this.reminderID,
      required this.medicineImage,
      required this.medicineName,
      required this.dosageAmount,
      required this.medicineUnit,
      required this.selectedID,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key(reminderID.toString()),
      padding: const EdgeInsets.all(12),
      child: Container(
        color: kNeutralWhite,
        height: 260,
        width: 149,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            reminderID == selectedID
                ? Stack(
                    children: [
                      Container(
                          foregroundDecoration: BoxDecoration(
                            color: kNeutral06,
                            backgroundBlendMode: BlendMode.saturation,
                          ),
                          child: MedicineImage(medicineImage: medicineImage)),
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
                            onSelect(-1);
                          }),
                          NikuButton(NikuText("Yes")
                                  .style(kBody05)
                                  .color(kNeutralWhite))
                              .onPressed(() async {
                            try {
                              await Provider.of<NotificationProvider>(context,
                                      listen: false)
                                  .takeMedicine(reminderID);
                              onSelect(-1);
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
                        ]).mainCenter()
                      ]).mainEnd()))
                    ],
                  )
                : GestureDetector(
                    onTap: () {
                      onSelect(reminderID);
                    },
                    child: MedicineImage(
                      medicineImage: medicineImage,
                    )),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                medicineName,
                style: kBody04Medium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 1.0),
              child: Text(
                'Amount ${dosageAmount} ${medicineUnit}',
                style: kBody05,
              ),
            )
          ],
        ),
      ),
    );
  }
}
