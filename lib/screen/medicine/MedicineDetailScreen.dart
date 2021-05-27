import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/medicine/medicineDetail.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:provider/provider.dart';

class MedicineDetailScreen extends StatelessWidget {
  static String routeName = '/medicine-detail';
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    try {
      Provider.of<MedicineProvider>(context, listen: false)
          .fetchMedicineById(routeArgs!["medicine_id"].toString());
    } on ErrorResponse catch (error) {
      if (error.toString() == "Unauthorize") {
        Provider.of<AuthenticateProvider>(context, listen: false).logout();
      } else {
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialog(error: error.toString()));
      }
    }
    return TemplateLayout(
      child: Niku(NikuColumn([
        Expanded(
          child: SingleChildScrollView(
            child: Consumer<MedicineProvider>(builder: (ctx, medicine, _) {
              Medicine? e = medicine.selectedMedicines;
              if (e != null)
                return MedicineDetail(
                  medicineID: e.medicineId,
                  medicineName: e.medicineName.toString(),
                  description: e.description.toString(),
                  medicineImage: e.medicineImage,
                  totalReceived: e.totalAmount,
                  dosagePerDose: e.dosageAmount,
                  medicineUnit: e.medicineUnit.toString(),
                  reminder: e.reminder,
                  remainAmount: e.remainAmount,
                  leafletImage: e.medicineLeaflet,
                );
              return Niku();
            }),
          ),
        ),
      ]).crossAxisAlignment(CrossAxisAlignment.stretch)),
      title: 'My Medicine',
      isHome: false,
    );
  }
}
