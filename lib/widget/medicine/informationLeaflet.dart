import 'package:famashi/config/api.dart';
import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:famashi/widget/utils/primaryButton.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class InformationLeaflet extends StatelessWidget {
  final String? leafletImage;
  InformationLeaflet({required this.leafletImage});
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      text: "Information Leaflet",
      isOutlined: true,
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Niku(
                  NikuColumn([
                    NikuRow([
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Iconly.close_square)),
                    ]).mainEnd(),
                    Niku(NikuText("Information Leaflet")
                        .style(kBody03Semibold.copyWith(color: kNeutral02))),
                    kSizedBoxVerticalM,
                    Niku()
                        .width(230.0)
                        .height(350.0)
                        .boxDecoration(BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(uploadEndpoint +
                                '/medicine_leaflet/' +
                                leafletImage.toString()),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: kNeutral04,
                        ))
                  ]).mainCenter().crossCenter(),
                ).height(500).width(300),
              ),
            );
          },
        );
      },
    );
  }
}
