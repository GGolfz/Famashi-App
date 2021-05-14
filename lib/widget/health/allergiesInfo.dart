import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/provider/allergiesProvider.dart';
import 'package:famashi/widget/health/detailTile.dart';
import 'package:famashi/widget/utils/customDivider.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class AllergiesInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<AllergiesProvider>(context, listen: false).fetchAllergies();
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kSizeS, vertical: kSizeXXS),
        child: Consumer<AllergiesProvider>(
          builder: (ctx, allergies, _) =>
              allergies.allergyList!.report.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (ctx, index) => DetailTile(
                        title: allergies.allergyList!.report[index]["title"]
                            .toString(),
                        detail: allergies.allergyList!.report[index]["detail"]
                            .toString(),
                        big: true,
                      ),
                      separatorBuilder: (context, index) => CustomDivider(),
                      itemCount: allergies.allergyList!.report.length,
                    )
                  : Niku(NikuText("No allergy").style(kBody03)).center(),
        ));
  }
}
