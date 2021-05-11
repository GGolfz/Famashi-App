import 'package:famashi/config/constant.dart';
import 'package:famashi/widget/utils/icon/Coolicons.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';

class FamashiAppbar extends StatelessWidget implements PreferredSizeWidget {
  final isHome;
  final title;
  final trailing;
  FamashiAppbar({@required this.title, this.isHome = true, this.trailing});
  @override
  Size get preferredSize => Size.fromHeight(kSizeL);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: isHome
          ? IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(CoolIcons.menu_alt_05))
          : IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.chevron_left)),
      title: Container(child: Text(title)),
    );
  }
}