import 'package:famashi/config/style.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/userNotificationProvider.dart';
import 'package:famashi/provider/userProvider.dart';
import 'package:famashi/provider/medicineProvider.dart';
import 'package:famashi/screen/medicine/MedicineAddScreen.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';
import 'package:famashi/widget/medicine/medicineInfo.dart';
import 'package:famashi/widget/medicine/emptyMedicine.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    try {
      Provider.of<UserProvider>(context, listen: false).fetchUser();
      Provider.of<MedicineProvider>(context, listen: false).fetchMedicines();
      Provider.of<UserNotificationProvider>(context, listen: false)
          .setupNotification();
    } on ErrorResponse catch (error) {
      if (error.toString() == "Unauthorize") {
        Provider.of<AuthenticateProvider>(context, listen: false).logout();
      } else {
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialog(error: error.toString()));
      }
    }
    return TemplateLayout(
        child: Niku(
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: NikuColumn([
              Consumer<UserProvider>(
                builder: (ctx, user, _) => Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: FittedBox(
                      child: NikuText(
                              "${user.user!.firstname} ${user.user!.lastname}")
                          .style(kTitle),
                      fit: BoxFit.fitWidth),
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
                        : EmptyMedicine(),
                  ),
                ),
              ),
            ]).crossStart(),
          ),
        ).height(double.infinity),
        hasAction: true,
        action: () async {
          Navigator.of(context).pushNamed(MedicineAddScreen.routeName);
        });
  }
}
