import 'package:dio/dio.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/button.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class MedicineAddScreen extends StatelessWidget {
  static String routeName = '/medicine-add';
  var medicineImage;
  var leafletImage;
  ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
      child: Niku(NikuColumn([
        Niku(NikuText("MED")).on(tap: () async {
          final file = await picker.getImage(source: ImageSource.gallery);
          medicineImage = await MultipartFile.fromFile(file!.path.toString());
        }),
        Niku(NikuText("LEAF")).on(tap: () async {
          final file = await picker.getImage(source: ImageSource.gallery);
          leafletImage = await MultipartFile.fromFile(file!.path.toString());
        }),
        NikuButton(NikuText("Submit")).onPressed(() async {
          await Provider.of<MedicineProvider>(context, listen: false)
              .createMedicine(medicineImage, leafletImage);
        })
      ])),
      title: 'Add Medicine',
      isHome: false,
    );
  }
}
