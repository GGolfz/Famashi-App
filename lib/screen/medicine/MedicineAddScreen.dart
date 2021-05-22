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
                        child: Container(
                          width: 149.0,
                          height: 207.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://i.pinimg.com/originals/a8/30/3a/a8303a4cbce1c08005c40c469c2565f7.jpg')),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            color: kNeutral04,
                          ),
                        ),
                        ),
                        AddMedicineForm(),
                        kSizedBoxHorizontalS,
                        Niku(NikuRow([
                          Icon(Iconly.danger,color: kNeutral03,size: 25,),
                          SizedBox(width: 10,),
                          NikuText("go to notification etting to change time.").style(kBody05SemiBold.copyWith(color: kNeutral03))
                        ]).crossCenter()).padding(EdgeInsets.fromLTRB(kSizeM, kSizeS, kSizeM, kSizeS)),
      
                        Niku(
                          PrimaryButton(text: "Add", 
                          onPressed:() async{
                          await Provider.of<MedicineProvider>(context, listen: false).createMedicine(medicineImage, leafletImage);
                          Navigator.of(context).pop();}),
                        ).padding(EdgeInsets.fromLTRB(40,5,40,5)),               

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
