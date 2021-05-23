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
import 'package:famashi/widget/medicine/editMedicineForm.dart';
import 'package:famashi/widget/medicine/addMedicineForm.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';

class MedicineEditScreen extends StatefulWidget {
  static String routeName = '/medicine-edit';

  @override
  State<MedicineEditScreen> createState() => _MedicineEditScreenState();
}

class _MedicineEditScreenState extends State<MedicineEditScreen> {
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
                        child: MedicineImage(medicineImage: null,),
                        ),
                        EditMedicineForm(),
                        // kSizedBoxHorizontalS,
                        // Niku(NikuRow([
                        //   Icon(Iconly.danger,color: kNeutral03,size: 25,),
                        //   SizedBox(width: 10,),
                        //   NikuText("go to notification etting to change time.").style(kBody05SemiBold.copyWith(color: kNeutral03))
                        // ]).crossCenter()).padding(EdgeInsets.fromLTRB(kSizeM, kSizeS, kSizeM, kSizeS)),
      
                        // Niku(
                        //   PrimaryButton(text: "Save", 
                        //   onPressed:() async{
                        //   await Provider.of<MedicineProvider>(context, listen: false).createMedicine(_medicineName.text,_description.text,int.parse(_totalRecieved.text),int.parse(_dosagePerDose.text),_medicineUnit.text,reminder, medicineImage, leafletImage);
                        //   Navigator.of(context).pop();}),
                        // ).padding(EdgeInsets.fromLTRB(40,5,40,5)),               

                  ],
                ),
              ),
            ),
                
            
          ],
        ).crossCenter(),
      ),
      title: 'Edit Medicine',
      isHome: false,
    );
  }
}
