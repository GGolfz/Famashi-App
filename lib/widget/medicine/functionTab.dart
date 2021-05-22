import 'package:famashi/config/color.dart';
import 'package:famashi/screen/medicine/MedicineEditScreen.dart';
import 'package:famashi/widget/utils/deleteDialog.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';

class FunctionTab extends StatelessWidget {
  final String medicineId;
  FunctionTab({required this.medicineId});
  @override
  Widget build(BuildContext context) {
    return NikuRow([
      IconButton(
          onPressed: () {
            Navigator.pushNamed(context, MedicineEditScreen.routeName);
          },
          icon: Icon(Iconly.edit_square)),
      IconButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) => DeleteDialog(
                  text: "medicine",
                  onDelete: () {
                    print("Delete medicine $medicineId");
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
