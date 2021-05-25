import 'package:famashi/config/style.dart';
import 'package:famashi/provider/userProvider.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/screen/medicine/MedicineAddScreen.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';
import 'package:famashi/widget/medicine/medicineInfo.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).fetchUser();
    Provider.of<MedicineProvider>(context, listen: false).fetchMedicines();
    return TemplateLayout(
        child: Niku(
          Padding(
            padding: const EdgeInsets.all(11.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Consumer<UserProvider>(
                builder: (ctx, user, _) => Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child:
                      NikuText("${user.user!.firstname} ${user.user!.lastname}")
                          .style(kTitle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                child: NikuText(
                  'here your medication',
                ).style(kBody03),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 25.0, left: 10.0, bottom: 5.0),
                child: NikuText(
                  'My Medication',
                ).style(kBody01Semibold),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Consumer<MedicineProvider>(
                    builder: (ctx, medicine, _) => medicine
                            .medicines!.isNotEmpty
                        ? Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 10.0,
                            runSpacing: 4.0,
                            children: medicine.medicines!
                                .map((e) => MedicineInfo(
                                      medicineID: e.medicineId,
                                      medicineImage: e.medicineImage,
                                      medicineName: e.medicineName.toString(),
                                      remainAmount: e.remainAmount,
                                    ))
                                .toList(),
                          )
                        : Niku(NikuText("No medicine")).center(),
                  ),
                ),
              ),
            ]),
          ),
        ).height(double.infinity),
        hasAction: true,
        action: () {
          Navigator.of(context).pushNamed(MedicineAddScreen.routeName);
        });
  }
}
