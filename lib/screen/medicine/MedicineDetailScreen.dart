import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/widget/medicine/informationLeaflet.dart';
import 'package:famashi/widget/medicine/medicineDetail.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:famashi/widget/medicine/functionTab.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';
import 'package:provider/provider.dart';

class MedicineDetailScreen extends StatelessWidget {
  static String routeName = '/medicine-detail';
  @override
  Widget build(BuildContext context) {
    Provider.of<MedicineProvider>(context, listen: false).fetchMedicines();
    return TemplateLayout(
      child: Niku(NikuColumn([
        Expanded(
          child: SingleChildScrollView(
            child: Consumer<MedicineProvider>(
              builder: (ctx, medicine, _) => Wrap(
                children: medicine.medicines!
                .map((e) => MedicineDetail(
                  medicineID: e.medicineId,
                  medicineName: e.medicineName.toString(),
                  description: e.description.toString(),
                  totalReceived: e.totalAmount,
                  dosagePerDose: e.dosageAmount,
                  medicineUnit: e.medicineUnit.toString(),
                  reminder: e.reminder.toString(),
                  remainAmount: e.remainAmount,
                  leafletImage: e.medicineLeaflet,
                ),
                ).toList(),
              ),
            ),
          ),
        ),
      ]).crossAxisAlignment(CrossAxisAlignment.stretch)),
      title: 'My Medicine',
      isHome: false,
    );
  }
}
