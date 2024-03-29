import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:famashi/widget/medicine/medicineForm.dart';

class MedicineAddScreen extends StatefulWidget {
  static String routeName = '/medicine-add';

  @override
  State<MedicineAddScreen> createState() => _MedicineAddScreenState();
}

class _MedicineAddScreenState extends State<MedicineAddScreen> {
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
      child: Niku(
        NikuColumn(
          [
            Expanded(
              child: SingleChildScrollView(
                child: MedicineForm(
                  medicine: Medicine.base,
                  type: "Add",
                ),
              ),
            ),
          ],
        ).crossCenter(),
      ),
      title: 'Add Medicine',
      isHome: false,
    );
  }
}
