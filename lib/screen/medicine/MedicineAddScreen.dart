import 'package:dio/dio.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/button.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';
import 'package:famashi/widget/utils/icon/CoolIcons.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:famashi/widget/utils/form/customSelector.dart';
import 'package:famashi/config/color.dart';
import 'package:famashi/widget/medicine/addMedicineForm.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';

class MedicineAddScreen extends StatefulWidget {
  static String routeName = '/medicine-add';

  @override
  State<MedicineAddScreen> createState() => _MedicineAddScreenState();
}

class _MedicineAddScreenState extends State<MedicineAddScreen> {
  var medicineImage;
  var leafletImage;

  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
      child: Niku(
        NikuColumn(
          [
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final file =
                            await picker.getImage(source: ImageSource.gallery);
                        medicineImage =
                            await MultipartFile.fromFile(file!.path.toString());
                      },
                      child: Stack(children: [
                        MedicineImage(medicineImage: null,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(55, 80, 55, 80),
                          child: Icon(
                            Iconly.image,
                            color: kNeutral06,
                            size: 40,
                          ),
                        ),
                      ]),
                    ),
                    AddMedicineForm(),
                   
                  ],
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
