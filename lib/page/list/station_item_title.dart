import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';


class StationItemTitle extends StatelessWidget {
  Function? onRefresh;
  StationItemTitle({super.key,required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double widthItem = width / 10;
    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: MyString.padding08,horizontal: MyString.padding08),
        decoration: const BoxDecoration(
          // color: Theme.of(context).primaryColorLight,
          color:MyColor.grey_tab,
          border: Border(
            bottom: BorderSide(width: 1.0, color: MyColor.grey_tab),
            top: BorderSide(width: 1.0, color: MyColor.grey_tab),
            left: BorderSide(width: 1.0, color: MyColor.grey_tab),
            right: BorderSide(width: 1.0, color: MyColor.grey_tab),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: widthItem,
              child: textcustom(
                text:"#",
                size: MyString.padding16,
                isBold: true
              ),
            ),
            const Divider(),
            SizedBox(
              width: widthItem,
              child: textcustom(text:"Member", size:MyString.padding16,isBold: true),
            ),
            SizedBox(
              width: widthItem,
              child: textcustom(text:"Machine", size:MyString.padding16,isBold: true),
            ),
            const Divider(),
            SizedBox(
              width: widthItem,
              child: textcustom(text:"Ip", size:MyString.padding16,isBold: true),
            ),
            const Divider(),
            SizedBox(
              width: widthItem,
              child: textcustom(text:"Bet", size:MyString.padding16,isBold: true),
            ),
            const Divider(),
            SizedBox(
                width: widthItem,
                child: textcustom(text:"Credit", size:MyString.padding16,isBold: true)),
            const Divider(),
            SizedBox(
                width: widthItem,
                child: textcustom(text:"Aft", size:MyString.padding16,isBold: true)),
            const Divider(),
            SizedBox(
                width: widthItem,
                child: textcustom(text:"Connect", size:MyString.padding16,isBold: true)),
            const Divider(),

             InkWell(
               onTap: (){
                onRefresh!();
               },
               child: SizedBox(
                    width: widthItem,
                    child: textcustom(text:"Status", size:MyString.padding16,isBold: true)),
             ),

            Expanded(
              child: InkWell(
                onTap: (){
                  onRefresh!();
                },
                child: SizedBox(
                    width: widthItem,
                    child: textcustom(text:"Action↺", size:MyString.padding16,isBold: true)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

