import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/model/rankingRLModel.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';
import 'package:tnm_app_slot_aft/util/format_date_custom.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';


class ItemListView extends StatelessWidget {
  const ItemListView({
    super.key,
    required this.post,
    required this.index,
    required this.onPressEdit,
    required this.onPressDelete,
  });
  final int index;
  final RankingRL post;
  final Function onPressEdit;
  final Function onPressDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final dateformat = DateFormatter();
    final width = MediaQuery.of(context).size.width;
    final itemWidth = width / 7.5;
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          // color:MyColor.white,
          border: Border(
            bottom: BorderSide(width: 1, color: MyColor.grey_tab),
            left: BorderSide(width: 1, color: MyColor.grey_tab),
            right: BorderSide(width: 1, color: MyColor.grey_tab),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: itemWidth,
                  child: textcustom(text: '${index + 1}', size: 16.0),
                ),
                SizedBox(
                  width: itemWidth,
                  child: textcustom(
                      text: post.customerNumber.toString(), size: 16.0),
                ),
                SizedBox(
                  width: itemWidth,
                  child: textcustom(
                      text: post.customerName.toString().toUpperCase(),
                      size: 16.0),
                ),
                SizedBox(
                  width: itemWidth,
                  child: textcustom(text: '${post.point}', size: 16.0),
                ),
                SizedBox(
                    width: itemWidth,
                    child: textcustom(
                        text: dateformat.formatTimeAFullLocal(
                            DateTime.parse(post.createdAt!)),
                        size: 16.0)),
                SizedBox(
                    width: itemWidth,
                    child:  textcustom(
                          text: dateformat.formatDate(DateTime.parse(post.createdAt!)),
                          size: 16.0)),
                Expanded(
                  child: SizedBox(
                      width: itemWidth,
                      child:
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              onPressEdit();
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              onPressDelete();
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    )),
                ),
              ],
            )),
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
