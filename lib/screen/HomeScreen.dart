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

class HomeScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> list = ["BB", "AB", "BN", "AN", "BD", "AD", "BED"];
  var myList = [];
  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).fetchUser();
    return TemplateLayout(
        child: Niku(NikuColumn([
          Consumer<UserProvider>(
            builder: (ctx, user, _) =>
                NikuText("${user.user!.firstname} ${user.user!.lastname}")
                    .style(kBody01Semibold),
          ),
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
                })
        ])).height(double.infinity),
        title: 'Home',
        hasAction: true,
        action: () {
          Navigator.of(context).pushNamed(MedicineAddScreen.routeName);
        });
  }
}
