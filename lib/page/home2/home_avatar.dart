
import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';

Widget avatarRow(
    {required double width,
    required double height,
    required Function onPressSetting,
    required String imageUrl,
    double avatarWidth = 42.0,
    required String userName}) {
  return  SizedBox(
    width: width * 0.875,
    height: height * 0.135,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: avatarWidth,
              height: avatarWidth,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(MyString.padding08),
                  color: MyColor.grey_tab),
            ),
            const SizedBox(
              width: MyString.padding08,
            ),
            textcustomColor(
                color: MyColor.white,
                text: "Hello, ${userName[0].toUpperCase()}${userName.substring(1).toLowerCase()}",
                isBold: true,
                size: MyString.padding16),
          ],
        ),
        IconButton(
            onPressed: () {
              onPressSetting();
            },
        icon:const Icon(Icons.menu_rounded, color: MyColor.white))
      ],
    ),
  );
}
