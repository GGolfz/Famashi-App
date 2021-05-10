import 'package:flutter/material.dart';

class FamashiDrawer extends StatelessWidget {
  final data = ["/", "/healthinfo", "/notification", "/setting"];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
          itemBuilder: (ctx, index) {
            return ListTile(
                title: Text(data[index].toString()),
                onTap: () {
                  Navigator.of(context).pushNamed(data[index]);
                });
          },
          separatorBuilder: (ctx, index) => Divider(),
          itemCount: data.length),
    );
  }
}
