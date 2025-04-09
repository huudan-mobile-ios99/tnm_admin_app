import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';

Widget customButton({
  required double width,
  required String text,
  required VoidCallback onTap, // Callback for button press
  double margin = 0.0, // Default margin value (0)
  double textSize = 22.0
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: margin), // Apply margin to left and right

    child: Material(
      color: Colors.blueAccent, // Button background color
      borderRadius: BorderRadius.circular(MyString.padding16), // Rounded corners
      child: InkWell(
        borderRadius: BorderRadius.circular(MyString.padding16), // Match the container's border radius
        onTap: onTap, // Action to perform when the button is tapped
        child: Container(
          width: width,
          height: 55.0,
          alignment: Alignment.center,
          child: textcustomColor(
            color: MyColor.white,
            size: textSize,
            text: text,
          ),
        ),
      ),
    ),
  );
}






Widget customButtonIcon({
  required double width,
  required String text,
  required VoidCallback onTap, // Callback for button press
  double margin = 0.0, // Default margin value (0)
  double textSize = 22.0,
  double borderRadius = 24.0,
  double itemHeight = 45.0,
  Icon icon = const Icon(Icons.send),
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: margin), // Apply margin to left and right

    child: Material(
      color: MyColor.white, // Button background color
      borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius), // Match the container's border radius
        onTap: onTap, // Action to perform when the button is tapped
        child: Container(
          width: width,
          height: itemHeight,
          decoration:BoxDecoration(
            color:MyColor.white,
            boxShadow: [
             BoxShadow(
              color: MyColor.white.withOpacity(0.25), // Shadow color with transparency
              offset: const Offset(MyString.padding02, MyString.padding02), // Offset of the shadow
              blurRadius: MyString.padding02, // Blur radius for soft edges
              spreadRadius: MyString.padding02, // Spread radius for shadow size
            ),
            ],
            border: Border.all(color:MyColor.grey_tab,width:1),
            borderRadius: BorderRadius.circular(borderRadius)
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width:MyString.padding04),
              textcustomColor(
                color: MyColor.black_absolute,
                size: textSize,
                text: text,
                isBold: true
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


Widget customButtonIconColorGradient({
  required double width,
  required String text,
  required VoidCallback onTap, // Callback for button press
  double margin = 0.0, // Default margin value (0)
  double textSize = 22.0,
  double borderRadius = 24.0,
  double itemHeight = 55.0,
  Icon icon = const Icon(Icons.send),
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: margin), // Apply margin to left and right
    child: Material(
      color: MyColor.white.withOpacity(.95), // Button background color
      borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius), // Match the container's border radius
        onTap: onTap, // Action to perform when the button is tapped
        child: Container(
          width: width,
          height: itemHeight,
          decoration:BoxDecoration(
            gradient: const LinearGradient(colors: [
              MyColor.pinkBG,MyColor.pinkBG2
            ]),
            border: Border.all(color:MyColor.grey_tab),
            borderRadius: BorderRadius.circular(borderRadius)
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width:MyString.padding04),
              textcustomColor(
                color: MyColor.white,
                size: textSize,
                text: text,
                isBold: true
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
