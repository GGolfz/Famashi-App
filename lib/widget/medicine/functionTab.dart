import 'package:famashi/config/color.dart';
import 'package:famashi/config/constant.dart';
import 'package:famashi/config/style.dart';
import 'package:famashi/widget/utils/icon/Iconly.dart';
import 'package:flutter/material.dart';
import 'package:niku/widget/axis.dart';
import 'package:niku/widget/base.dart';
import 'package:niku/widget/text.dart';

class FunctionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NikuRow([
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/medicine-edit');
                },
                icon: Icon(Iconly.edit_square)),
            IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 16,
                        child: Niku(
                          Padding(
                            padding: const EdgeInsets.all(.0),
                            child: NikuColumn(
                              [
                                Niku(NikuText("Are you sure to delete ").style(
                                    kBody04.copyWith(color: kNeutral01))),
                                Niku(NikuText("this medicine? ").style(
                                    kBody04.copyWith(color: kNeutral01))),
                                kSizedBoxVerticalS,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: NikuText("Cancel").style(
                                        kBody04.copyWith(color: kStateError),
                                      ),
                                    ),
                                    kSizedBoxHorizontalM,
                                    TextButton(
                                      style: ButtonStyle(
                                          padding:
                                              MaterialStateProperty.all<EdgeInsets>(
                                                  EdgeInsets.all(8)),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  kStateError),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(13.0),
                                                  side: BorderSide(
                                                      color: kStateError)))),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: NikuText("Delete").style(
                                        kBody04.copyWith(color: kNeutralWhite),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ).crossCenter().mainCenter(),
                          ),
                        ).height(150).width(120),
                      );
                    },
                  );
                },
                icon: Icon(
                  Iconly.delete,
                  color: kStateError,
                )),
          ]).mainEnd();
  }
}