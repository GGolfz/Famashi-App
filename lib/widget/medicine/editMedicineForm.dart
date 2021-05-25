import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:dio/dio.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/utils/format.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';
import 'package:famashi/widget/utils/form/customSelector.dart';
import 'package:famashi/widget/utils/icon/CoolIcons.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/widget.dart';
import 'package:famashi/widget/utils/form/customTextField.dart';

class EditMedicineForm extends StatefulWidget {
  
  @override
  State<EditMedicineForm> createState() => _EditMedicineFormState();
}

class _EditMedicineFormState extends State<EditMedicineForm> {
  var leafletImage;
  var medicineImage;
   ImagePicker picker = ImagePicker();
  List<String> list = ["Before morning", "After morning", "Before noon", "After noon", "Before evening", "After evening", "Bedtime"];
  var myList = [];
  final _medicineName = TextEditingController();
  final _description = TextEditingController();
  final _totalRecieved = TextEditingController();
  final _dosagePerDose = TextEditingController();
  final _medicineUnit = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Widget> _buildForm() {
    return [
      ..._buildTextFieldGroup("Medicine name", _medicineName),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("Description", _description),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("Total recieved", _totalRecieved),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("Dosage per dose", _dosagePerDose),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("Medicine unit", _medicineUnit),
      kSizedBoxVerticalXS,
      ..._buildTextFieldGroup("Medicine unit", _medicineUnit),
      kSizedBoxVerticalXS,
    ];
  }


  List<Widget> _buildTextFieldGroup(
      String text, TextEditingController controller) {
    return [
      NikuText(text).style(kBody04Medium).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      CustomTextField(
        controller: controller,
        name: text,
        hintText: text,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    // final routeArgs =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
//  Provider.of<MedicineProvider>(context, listen: false)
//         .fetchMedicineById(routeArgs!["medicine_id"].toString());
    return Niku(
      // Consumer<MedicineProvider>(builder: (ctx, medicine, _) {
            
             
      //             _medicineName.text = medicine.medicines!.medicineName.toString();
      //             _description.text = e.description.toString();
      //             medicineImage =e.medicineImage;
      //             _totalRecieved.text = e.totalAmount.toString();
      //             _dosagePerDose.text = e.dosageAmount.toString();
      //             _medicineUnit.text =  e.medicineUnit.toString();
      //             reminder: e.reminder;
      //             leafletImage: e.medicineLeaflet;
              
      // return
      NikuColumn([
        Center(
          child: GestureDetector(
                          onTap: () async {
                            final file =
                                await picker.getImage(source: ImageSource.gallery);
                            medicineImage =
                                await MultipartFile.fromFile(file!.path.toString());
                          },
                          child: MedicineImage(medicineImage: medicineImage,),
                          ),
        ),
      kSizedBoxVerticalM,
      ..._buildForm(),
      kSizedBoxVerticalM,
      GestureDetector(
          onTap: () async {
          final file = await picker.getImage(source: ImageSource.gallery);
          leafletImage = await MultipartFile.fromFile(file!.path.toString());
        },
          child:
          Container(
            height: 40,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor04),
              borderRadius: BorderRadius.circular(20.0)
            ),
            child:
            NikuRow(
              [
                Icon(Iconly.upload,
                color: kPrimaryColor04,),
                kSizedBoxHorizontalXS,
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: NikuText("Upload new information leaflet").style(kBody04Medium.copyWith(color: kPrimaryColor04)),
                ),
              ],
            ).crossCenter().mainCenter(),
            ),
        ),
      kSizedBoxVerticalM,
      NikuText("Set medecine reminder")
          .style(kBody04Medium)
          .color(kPrimaryColor05),
      kSizedBoxVerticalXS,
    
        ...myList.map((item) => Niku(NikuRow([
            Expanded(
              child: Niku(
                CustomSelector(
                  style: kBody05SemiBold.copyWith(color: kNeutral03),
                    current: item,
                    items: list
                        .where((element) =>
                            myList.indexOf(element) == -1 ||
                            element == item)
                        .toList(),
                    onChange: (val) {
                      setState(() {
                        var index = myList.indexOf(item);
                        myList[index] = val;
                      });
                    }),
              ).height(70).width(400),
            ),
            Niku(
              IconButton(
                  onPressed: () {
                    setState(() {
                      var index = myList.indexOf(item);
                      myList.removeAt(index);
                    });
                  },
                  icon: Icon(CoolIcons.close_big, color: kNeutral03,)),
            ).height(77)
          ],),),
        ).toList(),
      
      if (myList.length < 7)
        Padding(
          padding: const EdgeInsets.only(top:8.0),
          child: Niku(
            OutlinedButton(
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: kNeutral03,
                  ),
                  kSizedBoxHorizontalS,
                  Text(
                    "Add more",
                    style: kBody04Medium.copyWith(color: kNeutral03),
                  ),
                ],
              ),
              onPressed: () {
                for (var i in list) {
                  if (!myList.contains(i)) {
                    setState(() {
                      myList.add(i);
                    });
                    break;
                  }
                }
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ).height(55).width(400),
        ),
        kSizedBoxHorizontalS,
          Niku(NikuRow([
            Icon(
              Iconly.danger,
              color: kNeutral03,
              size: 25,
            ),
            SizedBox(
              width: 10,
            ),
            NikuText("go to notification editing to change time.")
                .style(kBody05SemiBold.copyWith(color: kNeutral03))
          ])).padding(EdgeInsets.only(top: 30, bottom: 20)),
          Niku(
            PrimaryButton(
                text: "Save",
                onPressed: () async {
                  var temp = myList.map((e) => formatTimeTypeToInt(e)).toList();
                  temp.sort();
                  String reminder = temp.join(',');
                  await Provider.of<MedicineProvider>(context, listen: false)
                      .editMedicine(
                          _medicineName.text,
                          _description.text,
                          int.parse(_totalRecieved.text),
                          int.parse(_dosagePerDose.text),
                          _medicineUnit.text,
                          reminder,
                          medicineImage,
                          leafletImage);
                  Navigator.of(context).pop();
                }),
          ).padding(EdgeInsets.fromLTRB(40, 5, 40, 5)),
        
    ]).crossStart()
    // ;})
    ).padding(EdgeInsets.all(kSizeM));
  }
}
