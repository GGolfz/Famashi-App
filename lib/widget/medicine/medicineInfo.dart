import 'package:famashi/config/color.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/widget.dart';
import 'package:famashi/config/style.dart';

class MedicineInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        color: kNeutralWhite,
        height: 252,
        width: 149,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left:5.0),
              child: Text(
                'Drug Name',
                style: kBody04Medium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:5.0,top: 1.0),
              child: Text('Remaining 12',
              style: kBody05,),
            )
          ],
        ),
      ),
    );
  }
}
