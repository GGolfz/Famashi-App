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
  List<String> list = ["BB", "AB", "BN", "AN", "BD", "AD", "BED"];
  var myList = [];
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
                  ],
                ),
              ),
            ),
                
            // Niku(
            //   ListView.builder(
            //     itemBuilder: (ctx, index) => Niku(NikuRow([
            //       Expanded(
            //           child: CustomSelector(
            //               current: myList[index],
            //               items: list
            //                   .where((element) =>
            //                       myList.indexOf(element) == -1 ||
            //                       element == myList[index])
            //                   .toList(),
            //               onChange: (val) {
            //                 setState(() {
            //                   myList[index] = val;
            //                 });
            //               })),
            //       IconButton(
            //           onPressed: () {
            //             setState(() {
            //               myList.removeAt(index);
            //             });
            //           },
            //           icon: Icon(CoolIcons.close_big))
            //     ])),
            //     itemCount: myList.length,
            //   ),
            // ).height(300),
            // if (myList.length < 7)
            //   PrimaryButton(
            //       text: "Add",
            //       onPressed: () {
            //         for (var i in list) {
            //           if (!myList.contains(i)) {
            //             setState(() {
            //               myList.add(i);
            //             });
            //             break;
            //           }
            //         }
            //       }),
            // Niku(NikuText("LEAF")).on(tap: () async {
            //   final file = await picker.getImage(source: ImageSource.gallery);
            //   leafletImage =
            //       await MultipartFile.fromFile(file!.path.toString());
            // }),
            // NikuButton(NikuText("Submit")).onPressed(() async {
            //   await Provider.of<MedicineProvider>(context, listen: false)
            //       .createMedicine(medicineImage, leafletImage);
            // })
          ],
        ).crossCenter(),
      ),
      title: 'Add Medicine',
      isHome: false,
    );
  }
}
