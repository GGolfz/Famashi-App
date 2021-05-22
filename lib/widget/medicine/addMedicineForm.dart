import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:dio/dio.dart';
import 'package:famashi/config/style.dart';
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

class AddMedicineForm extends StatefulWidget {
  @override
  State<AddMedicineForm> createState() => _AddMedicineFormState();
}

class _AddMedicineFormState extends State<AddMedicineForm> {
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

  @override
  Widget build(BuildContext context) {
  Provider.of<MedicineProvider>(context, listen: false).medicines;
    return Niku(NikuColumn([
      kSizedBoxVerticalXXS,
      NikuText("Medicine name").style(kBody04Medium).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      Form(
        key: _formKey,
        child: CustomTextField(
          controller: _medicineName,
          name: 'Medicine name',
          hintText: 'medicine name',
        ),
      ),
      kSizedBoxVerticalXS,
      NikuText("Description").style(kBody04Medium).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      CustomTextField(
        controller: _description,
        name: 'Description',
        hintText: 'description',
      ),
      kSizedBoxVerticalXS,
      NikuText("Total recieved").style(kBody04Medium).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      CustomTextField(
        controller: _totalRecieved,
        name: 'Total recieved',
        hintText: 'amount',
      ),
      kSizedBoxVerticalXS,
      NikuText("Dosage per dose").style(kBody04Medium).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      CustomTextField(
        controller: _dosagePerDose,
        name: 'Dosage per dose',
        hintText: 'amount',
      ),
      kSizedBoxVerticalXS,
      NikuText("Medicine unit").style(kBody04Medium).color(kPrimaryColor05),
      kSizedBoxVerticalXS,
      CustomTextField(
        controller: _medicineUnit,
        name: 'Medicine unit',
        hintText: 'amount',
      ),
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
                  child: NikuText("Upload information leaflet").style(kBody04Medium.copyWith(color: kPrimaryColor04)),
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
        
        
    ]).crossStart())
        .padding(EdgeInsets.all(kSizeM));
  }
}
