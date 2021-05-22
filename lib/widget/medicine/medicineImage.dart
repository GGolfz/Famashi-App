import 'package:flutter/material.dart';
import 'package:famashi/config/color.dart';

class MedicineImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
      Container(
            width: 149.0,
            height: 207.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://i.pinimg.com/originals/a8/30/3a/a8303a4cbce1c08005c40c469c2565f7.jpg')),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: kNeutral04,
            ),
    );
  }
}