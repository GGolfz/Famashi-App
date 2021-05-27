import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:famashi/widget/medicine/medicineForm.dart';
import 'package:provider/provider.dart';

class MedicineEditScreen extends StatefulWidget {
  static String routeName = '/medicine-edit';

  @override
  State<MedicineEditScreen> createState() => _MedicineEditScreenState();
}

class _MedicineEditScreenState extends State<MedicineEditScreen> {
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
      child: Niku(
        NikuColumn(
          [
            Expanded(
                child: SingleChildScrollView(
              child: Consumer<MedicineProvider>(
                  builder: (ctx, medicine, _) => MedicineForm(
                        medicine: medicine.selectedMedicines!,
                        type: "Edit",
                      )),
            )),
          ],
        ).crossCenter(),
      ),
      title: 'Edit Medicine',
      isHome: false,
    );
  }
}
