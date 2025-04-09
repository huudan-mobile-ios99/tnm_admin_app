
import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';

void showSnackBar({String? message, BuildContext? context}) {
  final snackBar = SnackBar(
    showCloseIcon: true,
    closeIconColor: MyColor.white,
    duration: const Duration(seconds: 1),
    backgroundColor: MyColor.pinkBG2,
    dismissDirection: DismissDirection.down,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    content: Align(
      alignment: Alignment.topCenter,
      child: Container(child: textcustomColor(color:MyColor.white,size: MyString.padding16,text:message)))
  );
  ScaffoldMessenger.of(context!).showSnackBar(snackBar);
}



void showSnackBarError({String? message, BuildContext? context,}) {
  final snackBar = SnackBar(
    showCloseIcon: true,
    closeIconColor: MyColor.white,
    duration: const Duration(seconds: 1),
    backgroundColor: MyColor.red_accent,
    content: Text(
      message!,
      style: const TextStyle(
        fontFamily: 'OpenSan',
        fontSize: 16.0,
        color: MyColor.white,
      ),
    ),
  );
  ScaffoldMessenger.of(context!).showSnackBar(snackBar);
}

