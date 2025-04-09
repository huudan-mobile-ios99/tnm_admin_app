import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/page/ranking_rl/rankingrlpage.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';
import 'package:tnm_app_slot_aft/widget/text_custom.dart';

Widget topRankingTitle({required BuildContext context,required double width}){
  return  Container(
                    color: Theme.of(context).primaryColorLight,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0.0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          itemListRT(
                              width: width,
                              child:textcustom(text: '#', size: MyString.padding14, isBold: false),
                          ),
                          itemListRT(
                            width: width,
                            child: textcustom(text: 'Number', size: MyString.padding14, isBold: false),
                          ),

                          itemListRT(
                            width: width,
                            child: textcustom(text: 'Name', size: MyString.padding14, isBold: false),
                          ),

                          itemListRT(
                            width: width,
                            child: textcustom(text: 'Point', size: MyString.padding14, isBold: false),
                          ),

                          itemListRT(
                            width: width,
                            child: textcustom(text: 'Time', size: MyString.padding14, isBold: false)),

                          Expanded(
                              child: itemListRT(
                                  width: width,
                                  child: textcustom(
                                      text: 'Action',
                                      size: MyString.padding14,
                                      isBold: false))),
                        ],
                      ),
                    ),
                  );
}
