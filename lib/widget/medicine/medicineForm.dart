import 'dart:io';

import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:dio/dio.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/userNotificationProvider.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/utils/format.dart';
import 'package:famashi/widget/medicine/medicineImage.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:famashi/widget/utils/form/customSelector.dart';
import 'package:famashi/widget/utils/icon/CoolIcons.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/widget.dart';
import 'package:famashi/widget/utils/form/customTextField.dart';

class MedicineForm extends StatefulWidget {
  final Medicine medicine;
  final String type;
  MedicineForm({required this.medicine, required this.type});
  @override
  State<MedicineForm> createState() => _MedicineFormState();
}

class _MedicineFormState extends State<MedicineForm> {
  var medicineImage;
  var leafletImage;
  var medicineImageDefault;
  var medicineImageFile;

  ImagePicker picker = ImagePicker();
  List<String> list = [
    "Before morning",
    "After morning",
    "Before noon",
    "After noon",
    "Before evening",
    "After evening",
    "Bedtime"
  ];

  var myList = [];
  final _medicineName = TextEditingController();
  final _description = TextEditingController();
  final _totalRecieved = TextEditingController();
  final _dosagePerDose = TextEditingController();
  final _medicineUnit = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _medicineName.text = widget.medicine.medicineName.toString();
    _description.text = widget.medicine.description.toString();
    _totalRecieved.text = widget.medicine.totalAmount.toString();
    _dosagePerDose.text = widget.medicine.dosageAmount.toString();
    _medicineUnit.text = widget.medicine.medicineUnit.toString();
    myList = widget.medicine.reminder;
    medicineImageDefault = widget.medicine.medicineImage;
    super.initState();
  }

  bool isUploadLeafLet() {
    return (leafletImage != null ||
        (widget.type == 'Edit' && widget.medicine.medicineLeaflet != null));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Niku(NikuColumn([
          Niku(GestureDetector(
            onTap: () async {
              final file = await picker.getImage(source: ImageSource.gallery);
              if (file != null) {
                medicineImage =
                    await MultipartFile.fromFile(file.path.toString());
                setState(() {
                  medicineImageFile = new File(file.path);
                });
              } else {
                medicineImage = null;
                medicineImageFile = null;
              }
            },
            child: Stack(children: [
              MedicineImage(
                medicineImage: medicineImageDefault,
                medicineImageFile: medicineImageFile,
                fromFile: medicineImageFile != null,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(55, 80, 55, 80),
                child: Icon(
                  Iconly.image,
                  color: kNeutral06,
                  size: 40,
                ),
              ),
            ]),
          )).center(),
          kSizedBoxVerticalXS,
          NikuText("Medicine name").style(kBody04Medium).color(kPrimaryColor05),
          kSizedBoxVerticalXS,
          CustomTextField(
            controller: _medicineName,
            name: 'Medicine name',
            hintText: 'medicine name',
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
          NikuText("Total recieved")
              .style(kBody04Medium)
              .color(kPrimaryColor05),
          kSizedBoxVerticalXS,
          CustomTextField(
            controller: _totalRecieved,
            name: 'Total recieved',
            hintText: 'amount',
            inputType: TextInputType.number,
          ),
          kSizedBoxVerticalXS,
          NikuText("Dosage per dose")
              .style(kBody04Medium)
              .color(kPrimaryColor05),
          kSizedBoxVerticalXS,
          CustomTextField(
            controller: _dosagePerDose,
            name: 'Dosage per dose',
            hintText: 'amount',
            inputType: TextInputType.number,
          ),
          kSizedBoxVerticalXS,
          NikuText("Medicine unit").style(kBody04Medium).color(kPrimaryColor05),
          kSizedBoxVerticalXS,
          CustomTextField(
            controller: _medicineUnit,
            name: 'Medicine unit',
            hintText: 'medicine unit',
          ),
          kSizedBoxVerticalM,
          GestureDetector(
            onTap: () async {
              final file = await picker.getImage(source: ImageSource.gallery);
              if (file != null) {
                leafletImage =
                    await MultipartFile.fromFile(file.path.toString());
                setState(() {
                  leafletImage = leafletImage;
                });
              } else {
                leafletImage = null;
                setState(() {
                  leafletImage = leafletImage;
                });
              }
            },
            child: Container(
              height: 40,
              width: 400,
              decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor04),
                  borderRadius: BorderRadius.circular(20.0),
                  color: isUploadLeafLet()
                      ? kPrimaryColor04.withAlpha(40)
                      : Colors.transparent),
              child: NikuRow(
                [
                  Icon(
                    isUploadLeafLet() ? Iconly.tick_square : Iconly.upload,
                    color: kPrimaryColor04,
                  ),
                  kSizedBoxHorizontalXS,
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: NikuText(isUploadLeafLet()
                            ? "Uploaded leaflet"
                            : "Upload information leaflet")
                        .style(kBody04Medium.copyWith(color: kPrimaryColor04)),
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
          ...myList
              .map(
                (item) => Niku(
                  NikuRow(
                    [
                      Expanded(
                        child: Niku(
                          CustomSelector(
                              style:
                                  kBody05SemiBold.copyWith(color: kNeutral03),
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
                            icon: Icon(
                              CoolIcons.close_big,
                              color: kNeutral03,
                            )),
                      ).height(77)
                    ],
                  ),
                ),
              )
              .toList(),
          if (myList.length < 7)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
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
                text: "${widget.type}",
                onPressed: () async {
                  var temp = myList.map((e) => formatTimeTypeToInt(e)).toList();
                  temp.sort();
                  String reminder = temp.join(',');
                  if (widget.type == "Add") {
                    try {
                      await Provider.of<MedicineProvider>(context,
                              listen: false)
                          .createMedicine(
                              _medicineName.text,
                              _description.text,
                              int.parse(_totalRecieved.text),
                              int.parse(_dosagePerDose.text),
                              _medicineUnit.text,
                              reminder,
                              medicineImage,
                              leafletImage);
                    } on ErrorResponse catch (error) {
                      if (error.toString() == "Unauthorize") {
                        Provider.of<AuthenticateProvider>(context,
                                listen: false)
                            .logout();
                      } else {
                        showDialog(
                            context: context,
                            builder: (ctx) =>
                                ErrorDialog(error: error.toString()));
                      }
                    }
                  } else if (widget.type == "Edit") {
                    try {
                      await Provider.of<MedicineProvider>(context,
                              listen: false)
                          .editMedicine(
                              widget.medicine.medicineId.toString(),
                              _medicineName.text,
                              _description.text,
                              int.parse(_totalRecieved.text),
                              widget.medicine.remainAmount,
                              int.parse(_dosagePerDose.text),
                              _medicineUnit.text,
                              reminder,
                              medicineImage,
                              leafletImage);
                    } on ErrorResponse catch (error) {
                      if (error.toString() == "Unauthorize") {
                        Provider.of<AuthenticateProvider>(context,
                                listen: false)
                            .logout();
                      } else {
                        showDialog(
                            context: context,
                            builder: (ctx) =>
                                ErrorDialog(error: error.toString()));
                      }
                    }
                  }
                  try {
                    await Provider.of<UserNotificationProvider>(context,
                            listen: false)
                        .setupNotification();
                  } on ErrorResponse catch (error) {
                    if (error.toString() == "Unauthorize") {
                      Provider.of<AuthenticateProvider>(context, listen: false)
                          .logout();
                    } else {
                      showDialog(
                          context: context,
                          builder: (ctx) =>
                              ErrorDialog(error: error.toString()));
                    }
                  }
                  Navigator.of(context).pop();
                }),
          ).padding(EdgeInsets.fromLTRB(40, 5, 40, 5)),
        ]).crossStart())
            .padding(EdgeInsets.all(kSizeM)));
  }
}
