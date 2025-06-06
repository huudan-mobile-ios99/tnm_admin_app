import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';

Widget mytextFieldTitle({
 required  double width,
 required Widget prefixIcon,
 hint,required TextEditingController? controller,
 required bool? enable,
 bool obscureText = false,
 double margin = 0.0, // Default margin value (0)
//  required String text,
 required TextInputType? textinputType,required String? label}) {
  // if (controller != null && text != null) {
  //   controller.text = text; // Set the initial value
  // }
  return Container(
    margin: EdgeInsets.symmetric(horizontal:margin),
    width: width,
    child: TextField(
      obscureText: obscureText,
      keyboardType: textinputType,
      controller: controller,
      enabled: enable,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        fillColor: MyColor.bedge,
        focusColor: MyColor.bedge,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: MyColor.grey_tab)
        ),
        hintText: "$hint",labelText: label),
    ),
  );
}







Widget mytextFieldTitleWithValue({
 required  double width,
 required Widget prefixIcon,
 hint,required TextEditingController? controller,
 required bool? enable,
 bool obscureText = false,
 double margin = 0.0, // Default margin value (0)
 required String text,
 required TextInputType? textinputType,required String? label}) {
  if (controller != null) {
    controller.text = text; // Set the initial value
  }
  return Container(
    margin: EdgeInsets.symmetric(horizontal:margin),
    width: width,
    child: TextField(
      obscureText: obscureText,
      keyboardType: textinputType,
      controller: controller,
      enabled: enable,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        fillColor: MyColor.bedge,
        focusColor: MyColor.bedge,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: MyColor.grey_tab)
        ),
        hintText: "$hint",labelText: label),
    ),
  );
}






Widget mytextFieldTitleSizeIcon({
  required double width,
  required Icon icon,
  String? hint,
  required TextEditingController? controller,
  required bool? enable,
  required TextInputType? textinputType,
  required String? label,
  String? text,
  String? Function(String?)? validator, // Add validator function

}) {
  // Update the controller's text only if it's different from the current value
  // if (controller != null && text != null && controller.text != text) {
  //   controller.text = text;
  // }

  return Container(
    margin: const EdgeInsets.only(bottom: MyString.padding08),
    decoration: BoxDecoration(
      color: MyColor.grey_tab_opa,
      borderRadius: BorderRadius.circular(MyString.padding16),
    ),
    width: width,
    child: TextFormField(
      validator: validator,
      selectionHeightStyle: BoxHeightStyle.tight,
      enableSuggestions: true,
      showCursor: true,
      keyboardType: textinputType,
      controller: controller,
      enabled: enable,
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: icon,
        border: InputBorder.none,
        fillColor: MyColor.grey_tab,
        hoverColor: MyColor.bedge,
        hintText: hint,
        labelText: label,
      ),
    ),
  );
}
