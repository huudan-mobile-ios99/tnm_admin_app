import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/model/jackpotDropModel.dart';
import 'package:tnm_app_slot_aft/page/home2/home_button.dart';
import 'package:tnm_app_slot_aft/page/hover/hover_cubit.dart';
import 'package:tnm_app_slot_aft/service/service_api_slot.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/format_date_custom.dart';
import 'package:tnm_app_slot_aft/util/functions.dart';
import 'package:tnm_app_slot_aft/util/snackbar_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/buttom_custom.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';


class ItemListViewJP extends StatelessWidget {
  const ItemListViewJP({
    super.key,
    required this.post,
    required this.index,
    required this.onPress,

  });
  final int index;
  final JackpotHistoryModelData post;
  final VoidCallback onPress;



  @override
  Widget build(BuildContext context) {
    final dateformat = DateFormatter();
    final width = MediaQuery.of(context).size.width;
    final itemWidth = width / 4.5;
    // Define the color for the first three items


    return BlocProvider(
      create: (_) => HoverCubit(),
      child: BlocBuilder<HoverCubit, bool>(
        builder: (context, state) => MouseRegion(
         onEnter: (_) => context.read<HoverCubit>().onHoverEnter(),
         onExit: (_) => context.read<HoverCubit>().onHoverExit(),
          child:post.machineId == null ? Container()  :  Container(
                  margin: const EdgeInsets.only(bottom:MyString.padding08),
                  decoration:BoxDecoration(
                    color:MyColor.white,
                    border:  Border.all(color:index == 0?  MyColor.pinkBG2 : Colors.transparent,width:1) ,
                    borderRadius: BorderRadius.circular(MyString.padding14)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal:MyString.padding08,vertical:MyString.padding12),
                  child:
                  Row(
                    children: [
                      SizedBox(
                        width: itemWidth/2,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:MyColor.yellowMain,
                            borderRadius: BorderRadius.circular(MyString.padding08)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal:MyString.padding02,vertical:MyString.padding04),
                          child: textcustomColor(color:MyColor.white, text: '${index + 1}', size: MyString.padding18,isBold:true)),
                      ),

                      Container(
                        padding: const EdgeInsets.only(left: MyString.padding08),
                        width: itemWidth+itemWidth/2+itemWidth*0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            textcustom(text: 'MC ${post.machineId}', size: MyString.padding18,isBold: true),
                            textcustom(text: dateformat.formatDateTimeTextFull(post.createdAt), size: MyString.padding12),
                          ],
                        )
                      ),

                      SizedBox(
                        width: itemWidth*0.7,
                        child: textcustomColor(
                            color:MyColor.green_araconda,
                            isBold: true,
                            text: '+\$${post.value.round()}',
                            size: MyString.padding20),
                      ),

                       (index <= 10)
                      ? Expanded(
                        child: Container(
                            // color:MyColor.grey_tab,
                            alignment:Alignment.center,
                            width: itemWidth,
                            child: customButtonIcon(
                              textSize: MyString.padding12,
                              itemHeight: 42.5,
                              margin: MyString.padding04,
                              icon: const Icon(Icons.reply_rounded,color:MyColor.pinkBG3,),
                              width: itemWidth, text: "ReCall", onTap:(){
                                debugPrint('on press chill jp item ${post.machineId} ${post.value.round()}');
                                validateInput(machine: '${post.machineId}', value: '${post.value.round()}') ==true ? showReCallDialog(context:context,width:width,machine:'${post.machineId}',value:"${post.value}" ) :
                                showSnackBar(context:context,message:"Invalid input, Can not recall transfer AFT");

                              })),
                      ) : Container(),
                    ],
                  )),
            ),
          ),
    );
  }
}




Widget rowItem({icon, String? text}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon),
      Text(
        text!,
      )
    ],
  );
}



void showReCallDialog({required BuildContext context,required double width,required String machine,required String value}) {
  showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  icon: const Icon(Icons.refresh_outlined),
                  title:textcustom(text: "Recall AFT?",size:MyString.padding18,isBold: true),
                  actions: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             textcustom(text: "Do you want to recall this transaction?",size:MyString.padding16),
                             const Divider(),
                             textcustom(text: "Machine: $machine",size:MyString.padding16),
                             textcustom(text: "AFT: ${convertToInt(value)}",size:MyString.padding16),
                          ],
                        ),
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
                              showSnackBar(context:context,message:"Recall to insert AFT successfull");
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
              );
}
