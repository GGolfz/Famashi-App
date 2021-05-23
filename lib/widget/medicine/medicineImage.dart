import 'package:flutter/material.dart';
import 'package:famashi/config/color.dart';

class MedicineImage extends StatelessWidget {
  final String? medicineImage;
  MedicineImage({required this.medicineImage});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 149.0,
      height: 207.0,
      decoration: BoxDecoration(
        image: medicineImage == null ? DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/medicine-default.png'), 
            ):DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(medicineImage.toString()), 
            ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: kNeutral04,
      ),
    );
  }
}
