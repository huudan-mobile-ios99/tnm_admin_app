
import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';

Widget card({required double width, required double height,
required Function onPressInfo,
required String value,required String machine}) {
  return Container(
    padding: const EdgeInsets.all(MyString.padding16),
    height: height,
    width: width,
    decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage("asset/bg_gradient.jpg"),fit: BoxFit.cover),
        boxShadow: [
        BoxShadow(
            color: MyColor.white.withOpacity(0.25), // Shadow color with transparency
            offset: const Offset(MyString.padding04, MyString.padding08), // Offset of the shadow
            blurRadius: MyString.padding16, // Blur radius for soft edges
            spreadRadius: MyString.padding08, // Spread radius for shadow size
          ),
        ],
        color: MyColor.white,
        // gradient: LinearGradient(
        //   colors: [MyColor.white, MyColor.grey_tab,MyColor.white,MyColor.grey_tab,MyColor.white], // Gradient colors
        //   begin: Alignment.topLeft, // Start gradient from top-left
        //   end: Alignment.bottomRight,
        // ),
        borderRadius:const BorderRadius.all(Radius.circular(MyString.padding16))),
        child: Stack(
          children: [
            Positioned(
              top: MyString.padding02,
              right:MyString.padding02,
              child: IconButton(onPressed: (){
                onPressInfo();
              }, icon:const Icon(Icons.info,size: MyString.padding28,)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textcustomColor(
                text: "TOURNAMENT MJP",
                color: MyColor.black_absolute,
                isBold: false,
                size: MyString.padding14),


                const SizedBox(height: MyString.padding16),

                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "JP AMOUNT     ",
                          style: TextStyle(
                            color: MyColor.black_absolute,
                            fontSize: MyString.padding20,
                            fontWeight: FontWeight.bold,
                            fontFamily: MyString.fontFamily,
                          ),
                        ),
                        TextSpan(
                          text:value=="0"?"\$_": "\$$value",
                          style: const TextStyle(
                            color: MyColor.yellowMainAcent,
                            fontSize: MyString.padding46,
                            fontWeight: FontWeight.bold,
                            fontFamily: MyString.fontFamily,

                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //LINE 2
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "MACHINE          ",
                          style: TextStyle(
                            color: MyColor.black_absolute,
                            fontFamily: MyString.fontFamily,
                            fontSize: MyString.padding20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:machine=='0' ? "#_" : "#$machine",
                          style: const TextStyle(
                            color: MyColor.pinkBG4,
                            fontWeight: FontWeight.bold,
                            fontFamily: MyString.fontFamily,
                            fontSize: MyString.padding32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
