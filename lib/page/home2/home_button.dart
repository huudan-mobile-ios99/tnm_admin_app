import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/service/service_api_slot.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/functions.dart';
import 'package:tnm_app_slot_aft/util/snackbar_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/buttom_custom.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';

Widget buttonRow(
    {
    required double width,
    required double height,
    required String value,required String machine,
    required BuildContext context
    }) {
  return Container(
    alignment: Alignment.center,
    width: width,
    height: height,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customButtonIcon(
            icon: const Icon(Icons.send_rounded, color: MyColor.pinkBG4),
            width: width / 3,
            text: "TRANSFER",
            onTap: () {
              debugPrint("click transfer mc: $machine - value: $value");
              validateInput(machine: machine,value: value) == true ?  showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon:const Icon(Icons.sell_outlined),
                  title:
                  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             textcustom(text: "Transfer AFT?",size:MyString.padding18,isBold: true),
                             const Divider(),
                             textcustom(text: "Machine: $machine",size:MyString.padding16),
                             textcustom(text: "AFT: ${convertToInt(value)}",size:MyString.padding16),
                          ],
                        ),
                  actions: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        textcustom(text: "Do you want to process this transaction?",size:MyString.padding16),
                        const SizedBox(height:MyString.padding16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          customButtonIcon(
                          width:width / 3,
                          textSize: MyString.padding16,
                          icon:const Icon(Icons.done_all_rounded,color:MyColor.green),
                          text:"YES",
                          onTap: (){
                            debugPrint("click yes");
                            final serviceAPIs = ServiceAPIsSlot();
                            serviceAPIs.updateAFTbyIP(ip:machine,aft:value).then((v){
                                showSnackBar(context:context,message: "Insert successfull");
                            }).whenComplete((){
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                        customButtonIcon(
                          width:width / 3,
                          textSize: MyString.padding16,
                          icon:const Icon(Icons.close_rounded,color:MyColor.red),
                          text:"NO",
                          onTap: (){
                            debugPrint("click no");
                            Navigator.of(context).pop();
                          },
                        ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
              :

             showSnackBar(context:context,message:"Invalid input, Can not transfer AFT");
            },
            textSize: MyString.padding14),
      ],
    ),
  );
}


bool validateInput({required String machine, required String value}) {
  // // Parse inputs to integers if they are valid numbers
  int? machineNumber = int.tryParse(machine);
  int? valueNumber = int.tryParse(value);
  // Check if both machine and value are valid positive integers
  if (machineNumber != null && machineNumber > 0 &&
      valueNumber != null && valueNumber > 0) {
    return true;
  }
  return false;
}
