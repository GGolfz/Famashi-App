import 'package:famashi/config/color.dart';
import 'package:famashi/screen/medicine/MedicineDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/widget.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';

class MedicineInfo extends StatelessWidget {
  final int medicineID;
  final String? medicineImage;
  final String medicineName;
  final int remainAmount;
  MedicineInfo({required this.medicineID,required this.medicineImage, required this.medicineName, required this.remainAmount });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        color: kNeutralWhite,
        height: 252,
        width: 149,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, MedicineDetailScreen.routeName,arguments:{"medicine_id": medicineID});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MedicineImage(medicineImage: medicineImage,),
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
                  'Remaining ' "${remainAmount.toString()}",
                  style: kBody05,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}