import 'dart:io';

import 'package:famashi/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:niku/widget/base.dart';

class ProfileImageSelector extends StatefulWidget {
  final ImagePicker picker = ImagePicker();

  final img;
  final onUpload;
  ProfileImageSelector({required this.img, required this.onUpload});
  @override
  _ProfileImageSelectorState createState() => _ProfileImageSelectorState();
}

class _ProfileImageSelectorState extends State<ProfileImageSelector> {
  var display_file;
  @override
  Widget build(BuildContext context) {
    return Niku(ClipRRect(
      child: display_file == null
          ? Image.network(
              widget.img,
              fit: BoxFit.cover,
            )
          : Image.file(
              display_file,
              fit: BoxFit.cover,
            ),
      borderRadius: kBorderRadiusS,
    ))
        .on(tap: () async {
          final file =
              await widget.picker.getImage(source: ImageSource.gallery);
          if (file != null) {
            setState(() {
              display_file = new File(file.path);
            });
            widget.onUpload(file);
          }
        })
        .height(kSizeL)
        .width(kSizeL);
  }
}
