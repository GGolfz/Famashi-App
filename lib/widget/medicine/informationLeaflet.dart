import 'dart:io';

import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class InformationLeaflet extends StatelessWidget {
  final String? leafletImage;
  InformationLeaflet({required this.leafletImage});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          style: ButtonStyle(
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(13)),
              foregroundColor:
                  MaterialStateProperty.all<Color>(kPrimaryColor04),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      side: BorderSide(color: kPrimaryColor04)))),
          child: NikuText("Information Leaflet")
              .style(kBody04Medium.copyWith(color: kPrimaryColor04)),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
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
                        Niku(NikuText("Information Leaflet").style(
                            kBody03Semibold.copyWith(color: kNeutral02))),
                        kSizedBoxVerticalM,
                        Container(
                          width: 230.0,
                          height: 350.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'http://13.76.251.165:3000/uploads/medicine_leaflet/' +
                                      leafletImage.toString()),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: kNeutral04,
                          ),
                        )
                      ]),
                    ).height(500).width(300),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
