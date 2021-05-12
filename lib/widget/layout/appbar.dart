import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/utils/icon/Coolicons.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';

class FamashiAppbar extends StatelessWidget implements PreferredSizeWidget {
  final isHome;
  final title;
  final trailing;
  FamashiAppbar({
    @required this.title,
    this.isHome = true,
    this.trailing,
  });
  @override
  Size get preferredSize => Size.fromHeight(kSizeL);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isHome
          ? IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(
                CoolIcons.menu_alt_05,
                size: kSizeM,
                color: kNeutral01,
              ))
          : IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Iconly.arrow_left,
                color: kNeutral01,
                size: kSizeM,
              )),
      title: Container(child: Text(title, style: kBody01Semibold)),
      titleSpacing: 0,
      centerTitle: false,
      backgroundColor: kNeutralWhite,
      foregroundColor: kNeutralBlack,
      backwardsCompatibility: false,
      actions: trailing != null ? trailing : [],
      elevation: 0,
    );
  }
}
