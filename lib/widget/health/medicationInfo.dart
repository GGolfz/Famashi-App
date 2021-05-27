import 'package:famashi/config/constant.dart';
import 'package:famashi/provider/authenticateProvider.dart';
import 'package:famashi/provider/usageProvider.dart';
import 'package:famashi/utils/error.dart';
import 'package:famashi/widget/health/detailTile.dart';
import 'package:famashi/widget/health/emptyMedicationInfo.dart';
import 'package:famashi/widget/utils/customDivider.dart';
import 'package:famashi/widget/utils/errorDialog.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';
import 'package:provider/provider.dart';

class MedicationInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    try {
      Provider.of<UsageProvider>(context, listen: false).fetchUsageHistory();
    } on ErrorResponse catch (error) {
      if (error.toString() == "Unauthorize") {
        Provider.of<AuthenticateProvider>(context, listen: false).logout();
      } else {
        showDialog(
            context: context,
            builder: (ctx) => ErrorDialog(error: error.toString()));
      }
    }
    return Container(
        padding: EdgeInsets.symmetric(horizontal: kSizeS, vertical: kSizeXXS),
        child: Consumer<UsageProvider>(
          builder: (ctx, usage, _) => usage.usageList!.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (ctx, index) => DetailTile(
                    title: usage.usageList![index].title,
                    detail: usage.usageList![index].detail,
                  ),
                  separatorBuilder: (context, index) => CustomDivider(),
                  itemCount: usage.usageList!.length,
                )
              : EmptyMedicationInfo(),
        ));
  }
}
