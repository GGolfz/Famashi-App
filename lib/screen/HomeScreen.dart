import 'package:famashi/config/color.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/userProvider.dart';
import 'package:famashi/screen/medicine/MedicineAddScreen.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/form/customSelector.dart';
import 'package:famashi/widget/utils/icon/CoolIcons.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
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
  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).fetchUser();
    return TemplateLayout(
        child: Niku(
          Padding(
            padding: const EdgeInsets.all(11.0),
            child:
              Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
              Consumer<UserProvider>(
                builder: (ctx, user, _) =>
                    NikuText("${user.user!.firstname} ${user.user!.lastname}")
                        .style(kTitle),
              ),
              Padding(
                padding: const EdgeInsets.only(top:4.0),
                child: Text(
                  'here your medication',
                  style: kBody03,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:25.0),
                child: Text(
                  'My Medication',
                  style: kBody01Semibold,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                runSpacing: 4.0,
                  children: [
                    MedicineInfo(),
                    MedicineInfo(),
                     MedicineInfo(),
                    MedicineInfo(),
                   
                  ],
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

