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
      child: Niku(NikuColumn([
        Niku(NikuText("MED")).on(tap: () async {
          final file = await picker.getImage(source: ImageSource.gallery);
          medicineImage = await MultipartFile.fromFile(file!.path.toString());
        }),
        Niku(
            ListView.builder(
              itemBuilder: (ctx, index) => Niku(NikuRow([
                Expanded(
                    child: CustomSelector(
                        current: myList[index],
                        items: list
                            .where((element) =>
                                myList.indexOf(element) == -1 ||
                                element == myList[index])
                            .toList(),
                        onChange: (val) {
                          setState(() {
                            myList[index] = val;
                          });
                        })),
                IconButton(
                    onPressed: () {
                      setState(() {
                        myList.removeAt(index);
                      });
                    },
                    icon: Icon(CoolIcons.close_big))
              ])),
              itemCount: myList.length,
            ),
          ).height(500),
          if (myList.length < 7)
            PrimaryButton(
                text: "Add",
                onPressed: () {
                  for (var i in list) {
                    if (!myList.contains(i)) {
                      setState(() {
                        myList.add(i);
                      });
                      break;
                    }
                  }
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
