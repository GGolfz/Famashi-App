import 'package:flutter/material.dart';
import 'package:famashi/config/color.dart';

class MedicineImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 149.0,
      height: 207.0,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/medicine-default.png")),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: kNeutral04,
      ),
    );
  }
}
