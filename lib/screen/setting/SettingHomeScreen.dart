import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/layout/template.dart';
import 'package:famashi/widget/utils/customDivider.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/text.dart';

class SettingHomeScreen extends StatelessWidget {
  static String routeName = '/setting';
  final List<Map<String, String>> data = [
    {"name": "Profile setting", "route": "/setting-profile"},
    {"name": "Notification setting", "route": "/setting-notification"},
    {"name": "Change password", "route": "/setting-password"},
  ];
  @override
  Widget build(BuildContext context) {
    return TemplateLayout(
      child: Container(
          padding: EdgeInsets.all(kSizeS),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NikuText("Setting").style(kBody01Semibold),
              kSizedBoxVerticalXS,
              CustomDivider(),
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (ctx, index) => ListTile(
                            title: NikuText(data[index]["name"].toString())
                                .style(kBody04SemiBold)
                                .color(kNeutral02),
                            trailing: Icon(
                              Iconly.arrow_right_2,
                              color: kNeutral04,
                              size: kSizeS * 1.5,
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(data[index]["route"].toString());
                            },
                            contentPadding: EdgeInsets.all(kSizeXS),
                          ),
                      separatorBuilder: (ctx, index) => CustomDivider(),
                      itemCount: data.length))
            ],
          )),
    );
  }
}
