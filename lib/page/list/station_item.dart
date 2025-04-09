import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnm_app_slot_aft/model/stationModel.dart';
import 'package:tnm_app_slot_aft/page/hover/hover_cubit.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/format_date_custom.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';


class StationItem extends StatelessWidget {
  const StationItem({
    super.key,
    required this.post,
    required this.index,
    required this.onPressEdit,
    required this.onPressDelete,
    required this.onPressView,
  });
  final int index;
  final StationModel post;
  final Function onPressEdit;
  final Function onPressDelete;
  final Function onPressView;


  @override
  Widget build(BuildContext context) {
    final dateformat = DateFormatter();
    final width = MediaQuery.of(context).size.width;
    final itemWidth = width / 10;

    Color itemColor(connection){
      if(connection == 1) {
        return Colors.transparent ;
      }
      return MyColor.red_bg_opacity;
    }

    return BlocProvider(
      create: (_) => HoverCubit(),
      child: BlocBuilder<HoverCubit, bool>(
        builder: (context, state) => MouseRegion(
         onEnter: (_) => context.read<HoverCubit>().onHoverEnter(),
         onExit: (_) => context.read<HoverCubit>().onHoverExit(),
          child: Container(
            color:itemColor(post.connect),
            child: Container(
              decoration:  BoxDecoration(
                color:state ?  MyColor.bedgeLight : Colors.transparent,
                border: const Border(
                  bottom: BorderSide(width: 1, color: MyColor.grey_tab),
                  left: BorderSide(width: 1, color: MyColor.grey_tab),
                  right: BorderSide(width: 1, color: MyColor.grey_tab),
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(MyString.padding08),
                  child: Row(
                    children: [
                      SizedBox(
                        width: itemWidth,
                        child: textcustom(text: '${index + 1}', size: MyString.padding14),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: textcustom(
                            text: post.member, size: MyString.padding14),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: textcustom(
                            text: post.machine,
                            size: MyString.padding14),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: textcustom(
                          text:'${post.ip}', size: MyString.padding14),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: textcustom(text: '\$${post.bet / 100}', size: MyString.padding14),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: textcustom(text: '\$${post.credit / 100}', size: MyString.padding14),
                      ),

                      SizedBox(
                          width: itemWidth,
                          child: textcustom(
                              text: '${post.aft}',
                              size: MyString.padding14)),
                       SizedBox(
                          width: itemWidth,
                          child: textcustomColor(
                                                  size: MyString.padding14,
                                                  text: post.connect == 1
                                                      ? 'connected'
                                                      : 'disconnect',
                                                  color: post.connect == 1
                                                      ? Colors.green
                                                      : Colors.red,
                                                )),
                                                SizedBox(
                          width: itemWidth,
                          child: textcustomColor(
                                                  size: MyString.padding14,
                                                  text: post.status == 1
                                                      ? 'enable'
                                                      : 'disable',
                                                  color: post.status == 1
                                                      ? Colors.green
                                                      : Colors.red,
                                                )),
                      Expanded(
                      child:SizedBox(
                      width: itemWidth,
                      child: Row(
                      children: [
                        IconButton(
                                    tooltip: "View",
                                    onPressed: () {
                                      onPressView();
                                    },
                                    icon: const Icon(Icons.info,color:Colors.lightBlue)),
                      ],
                    )),
                      ),
                    ],
                  )),
            ),
          ),
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
