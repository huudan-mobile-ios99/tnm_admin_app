
import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/util/string_custom_slot.dart';

Widget loadingIndicatorSize() {
  return Container(
    alignment: Alignment.center,
    height:MyString.padding32,
    child: const Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator.adaptive(strokeWidth: 1.0,backgroundColor: Colors.grey,),
      ],
    )
  );
}


