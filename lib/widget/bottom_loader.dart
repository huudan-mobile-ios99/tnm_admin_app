import 'package:flutter/material.dart';

class BottomLoaderCustom extends StatelessWidget {
  Function? function;
  BottomLoaderCustom({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // const SizedBox(height: MyString.padding08,),
          TextButton(
            onPressed: () {
              function!();
            },
          child: const Text('Refresh'))
        ],
      ),
    );
  }
}



