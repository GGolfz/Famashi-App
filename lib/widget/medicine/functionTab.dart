import 'package:famashi/config/color.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/screen/medicine/MedicineEditScreen.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/utils/deleteDialog.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:provider/provider.dart';

class FunctionTab extends StatelessWidget {
  final String medicineId;
  FunctionTab({required this.medicineId});
  @override
  Widget build(BuildContext context) {
    return NikuRow([
      IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(MedicineEditScreen.routeName,
                arguments: {"medicine_id": medicineId.toString()});
          },
          icon: Icon(Iconly.edit_square)),
      IconButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => DeleteDialog(
                  text: "medicine",
                  onDelete: () async {
                    try {
                      await Provider.of<MedicineProvider>(context,
                              listen: false)
                          .deleteMedicine(medicineId);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } on ErrorResponse catch (error) {
                      showDialog(
                          context: context,
                          builder: (ctx) =>
                              ErrorDialog(error: error.toString()));
                    }
                  }),
            );
          },
          icon: Icon(
            Iconly.delete,
            color: kStateError,
          )),
    ]).mainEnd();
  }
}
