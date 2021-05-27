import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/userProvider.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/utils/customDivider.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/text.dart';
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
    try {
      Provider.of<UserProvider>(context, listen: false).fetchUser();
    } on ErrorResponse catch (error) {
      if (error.toString() == "Unauthorize") {
        Provider.of<AuthenticateProvider>(context, listen: false).logout();
      } else {
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialog(error: error.toString()));
      }
    }
    return Drawer(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: kSizeS),
            child: Column(children: [
              kSizedBoxVerticalL,
              Consumer<UserProvider>(
                  builder: (ctx, user, _) => Container(
                      margin: EdgeInsets.all(kSizeXS),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: kBorderRadiusS,
                              child: SizedBox(
                                  width: kSizeL,
                                  height: kSizeL,
                                  child: Image.network(
                                    user.user!.img,
                                    fit: BoxFit.contain,
                                  ))),
                          kSizedBoxHorizontalS,
                          NikuText(
                                  "${user.user!.firstname} ${user.user!.lastname}")
                              .style(kBody03Medium)
                              .color(kAccentColor04)
                        ],
                      ))),
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
                            title: NikuText(
                              item["name"].toString(),
                            ).style(kBody04Medium).color(kNeutral02),
                            horizontalTitleGap: 0,
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(item["route"].toString());
                            });
                      },
                      itemCount: drawerData.length)),
              ListTile(
                  leading: Icon(Iconly.logout, color: kPrimaryColor02),
                  title: NikuText("Log Out")
                      .style(kBody03Medium)
                      .color(kNeutral02),
                  horizontalTitleGap: 0,
                  onTap: () async {
                    await Provider.of<AuthenticateProvider>(context,
                            listen: false)
                        .logout();
                    Navigator.of(context).pushNamed('/');
                  })
            ])));
  }
}
