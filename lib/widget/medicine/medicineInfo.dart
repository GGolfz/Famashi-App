import 'package:famashi/config/color.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/widget.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';

class MedicineInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        color: kNeutralWhite,
        height: 252,
        width: 149,
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/medicine-detail');
          } ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MedicineImage(),
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
      ),
    );
  }
}
