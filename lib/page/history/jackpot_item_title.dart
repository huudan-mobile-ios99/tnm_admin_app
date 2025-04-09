import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';


class AdminItemTitleJP extends StatelessWidget {
  Function? onRefresh;
  AdminItemTitleJP({super.key,required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final double widthItem = width / 8.5;
    return Material(
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: MyString.padding08,),
        // margin: const EdgeInsets.symmetric(vertical:MyString.padding08),
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
              child: textcustom(text:"Name", size:MyString.padding16,isBold: true),
            ),
            SizedBox(
              width: widthItem,
              child: textcustom(text:"Value", size:MyString.padding16,isBold: true),
            ),
            const Divider(),
            SizedBox(
              width: widthItem,
              child: textcustom(text:"Machine", size:MyString.padding16,isBold: true),
            ),
            const Divider(),
            SizedBox(
              width: widthItem,
              child: textcustom(text:"Count", size:MyString.padding16,isBold: true),
            ),
            const Divider(),
            SizedBox(
                width: widthItem,
                child: textcustom(text:"Time", size:MyString.padding16,isBold: true)),
            const Divider(),
            SizedBox(
                width: widthItem,
                child: textcustom(text:"Date", size:MyString.padding16,isBold: true)),
            const Divider(),
            Expanded(
              child: Container(
                  alignment: Alignment.center,
                  width: widthItem,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      textcustom(text:"Action", size:MyString.padding16,isBold: true),
                      IconButton(
                        tooltip: "Refresh View",
                        onPressed: (){onRefresh!();}, icon: const Icon(Icons.refresh))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

