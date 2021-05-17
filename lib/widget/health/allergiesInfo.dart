import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/allergiesProvider.dart';
import 'package:famashi/widget/health/detailTile.dart';
import 'package:famashi/widget/utils/customDivider.dart';
import 'package:famashi/widget/utils/deleteDialog.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/button.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class AllergiesInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<AllergiesProvider>(context, listen: false).fetchAllergies();
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kSizeS, vertical: kSizeXXS),
        child: Consumer<AllergiesProvider>(
          builder: (ctx, allergies, _) => allergies
                  .allergyList!.report.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (ctx, index) => Dismissible(
                    key: GlobalKey(
                        debugLabel: allergies.allergyList!.report[index]["id"]
                            .toString()),
                    background: Niku(Icon(
                      Iconly.delete,
                      color: kNeutralWhite,
                    ))
                        .align(Alignment.centerRight)
                        .padding(EdgeInsets.symmetric(horizontal: kSizeM))
                        .backgroundColor(kStateErrorBG),
                    direction: DismissDirection.endToStart,
                    child: DetailTile(
                      title: allergies.allergyList!.report[index]["title"]
                          .toString(),
                      detail: allergies.allergyList!.report[index]["detail"]
                          .toString(),
                      big: true,
                    ),
                    confirmDismiss: (val) {
                      return showDialog(
                          context: context,
                          builder: (ctx) => DeleteDialog(
                              text: "allergy",
                              onDelete: () async {
                                await Provider.of<AllergiesProvider>(context,
                                        listen: false)
                                    .deleteAllergy(allergies
                                        .allergyList!.report[index]["id"]);
                                Navigator.of(ctx).pop(true);
                              }));
                    },
                  ),
                  separatorBuilder: (context, index) => CustomDivider(),
                  itemCount: allergies.allergyList!.report.length,
                )
              : Niku(NikuText("No allergy").style(kBody03)).center(),
        ));
  }
}
