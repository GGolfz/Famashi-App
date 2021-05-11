import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/widget/utils/customDiver.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FamashiDrawer extends StatelessWidget {
  final drawerData = <Map<String, dynamic>>[
    {"name": "My Medication", "route": "/", "icon": Iconly.bookmark},
    {
      "name": "My Health Information",
      "route": "/healthinfo",
      "icon": Iconly.chart
    },
    {
      "name": "Notification",
      "route": "/notification",
      "icon": Iconly.notification
    },
    {"name": "Setting", "route": "/setting", "icon": Iconly.setting}
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: kSizeS),
            child: Column(children: [
              kSizedBoxVerticalL,
              Container(
                  margin: EdgeInsets.all(kSizeXS),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: kBorderRadiusS,
                          child: SizedBox(
                              width: kSizeL,
                              height: kSizeL,
                              child: Image.network(
                                "https://instagram.fbkk22-4.fna.fbcdn.net/v/t51.2885-15/e35/s1080x1080/174779557_377856969974255_5115754287508607467_n.jpg?tp=1&_nc_ht=instagram.fbkk22-4.fna.fbcdn.net&_nc_cat=111&_nc_ohc=UKBK5XkAvE0AX9hVIdS&edm=AP_V10EBAAAA&oh=3f1caf91d014925d74332acb0bca0160&oe=60C0C9B1",
                                fit: BoxFit.contain,
                              ))),
                      kSizedBoxHorizontalS,
                      Text(
                        "Kaewket Saelee",
                        style: kBody03Medium.copyWith(color: kAccentColor04),
                      )
                    ],
                  )),
              kSizedBoxVerticalS,
              CustomDivider(),
              kSizedBoxVerticalXS,
              Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, index) {
                        final item = drawerData[index];
                        return ListTile(
                            leading: Icon(
                              item["icon"],
                              color: kPrimaryColor02,
                            ),
                            title: Text(
                              item["name"].toString(),
                              style: kBody04Medium.copyWith(color: kNeutral02),
                            ),
                            horizontalTitleGap: 0,
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(item["route"].toString());
                            });
                      },
                      itemCount: drawerData.length)),
              ListTile(
                  leading: Icon(Iconly.logout, color: kPrimaryColor02),
                  title: Text(
                    "Log Out",
                    style: kBody03Medium.copyWith(color: kNeutral02),
                  ),
                  horizontalTitleGap: 0,
                  onTap: () async {
                    Provider.of<AuthenticateProvider>(context, listen: false)
                        .logout();
                  })
            ])));
  }
}
