import 'dart:io';
import 'package:famashi/config/api.dart';
import 'package:flutter/material.dart';
import 'package:famashi/config/color.dart';

class MedicineImage extends StatelessWidget {
  final String? medicineImage;
  final bool fromFile;
  final File? medicineImageFile;
  MedicineImage(
      {required this.medicineImage,
      this.fromFile = false,
      this.medicineImageFile});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 149.0,
      height: 207.0,
      decoration: BoxDecoration(
        image: fromFile
            ? DecorationImage(
                fit: BoxFit.cover, image: FileImage(medicineImageFile!))
            : (medicineImage == null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/medicine-default.png'),
                  )
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(uploadEndpoint +
                        '/medicine_image/' +
                        medicineImage.toString()),
                  )),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: kNeutral04,
      ),
    );
  }
}
