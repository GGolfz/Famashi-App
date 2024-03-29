import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/health/allergiesForm.dart';
import 'package:famashi/widget/health/allergiesInfo.dart';
import 'package:famashi/widget/health/generalInfo.dart';
import 'package:famashi/widget/health/medicationInfo.dart';
import 'package:famashi/widget/health/tabList.dart';
import 'package:famashi/widget/layout/popup.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/customDivider.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class HealthInfoScreen extends StatefulWidget {
  static String routeName = '/healthinfo';

  @override
  _HealthInfoScreenState createState() => _HealthInfoScreenState();
}

enum TabType { Allergies, General, Medication }

class _HealthInfoScreenState extends State<HealthInfoScreen> {
  final _tabs = [
    {"label": "Allergies", "type": TabType.Allergies},
    {"label": "General Info", "type": TabType.General},
    {"label": "Medication Info", "type": TabType.Medication}
  ];
  var _selectedTab = TabType.Allergies;

  Widget getScreenBody() {
    switch (_selectedTab) {
      case TabType.Allergies:
        return AllergiesInfo();
      case TabType.General:
        return GeneralInfo();
      case TabType.Medication:
        return MedicationInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
      child: Niku(NikuColumn(
        [
          NikuText("My Health Information").style(kBody01Semibold),
          kSizedBoxVerticalS,
          TabList(
              tabs: _tabs,
              selected: _selectedTab,
              changeType: (tab) {
                setState(() {
                  _selectedTab = tab;
                });
              }),
          kSizedBoxVerticalXS,
          CustomDivider(),
          Expanded(child: getScreenBody())
        ],
      ).crossStart())
          .padding(EdgeInsets.all(kSizeS)),
      hasAction: _selectedTab == TabType.Allergies,
      action: () {
        showDialog(
            context: context, builder: (ctx) => Popup(widget: AllergiesForm()));
      },
    );
  }
}
