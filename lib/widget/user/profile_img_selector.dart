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
  var displayFile;
  @override
  Widget build(BuildContext context) {
    return Niku(ClipRRect(
      child: displayFile == null
          ? Image.network(
              widget.img,
              fit: BoxFit.cover,
            )
          : Image.file(
              displayFile,
              fit: BoxFit.cover,
            ),
      borderRadius: kBorderRadiusS,
    ))
        .on(tap: () async {
          final file =
              await widget.picker.getImage(source: ImageSource.gallery);
          if (file != null) {
            setState(() {
              displayFile = new File(file.path);
            });
            widget.onUpload(file);
          }
        })
        .height(kSizeL)
        .width(kSizeL);
  }
}
