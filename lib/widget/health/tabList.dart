import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/screen/HealthInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class TabList extends StatelessWidget {
  final tabs;
  final selected;
  final changeType;
  TabList(
      {required this.tabs, required this.selected, required this.changeType});
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...tabs
              .map((e) => Niku(NikuText(e["label"].toString())
                          .style(kBody03Medium)
                          .color(
                              selected == e["type"] ? kNeutral06 : kNeutral03))
                      .padding(
                        EdgeInsets.symmetric(
                            horizontal: kSizeS, vertical: kSizeXXS),
                      )
                      .boxDecoration(
                        BoxDecoration(
                            borderRadius: kBorderRadiusS,
                            color: selected == e["type"]
                                ? kPrimaryColor05
                                : kNeutralWhite),
                      )
                      .margin(EdgeInsets.symmetric(horizontal: kSizeXXS))
                      .on(tap: () {
                    var position = 0.0;
                    switch (e["type"]) {
                      case TabType.Allergies:
                        position = 0.0;
                        break;
                      case TabType.General:
                        position = 28.0;
                        break;
                      case TabType.Medication:
                        position = 97.0;
                        break;
                    }
                    _controller.animateTo(position,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut);
                    changeType(e["type"]);
                  }))
              .toList()
        ],
      ),
    ));
  }
}
