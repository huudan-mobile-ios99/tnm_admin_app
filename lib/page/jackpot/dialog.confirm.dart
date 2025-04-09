import 'package:flutter/material.dart';
import 'package:tnm_app_slot_aft/util/color_custom.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  final String actionTitle;
  final String? actionSubTitle;
  final VoidCallback onConfirmed;

  const ConfirmationDialogWidget({
    super.key,
    required this.actionTitle,
    required this.onConfirmed,
    this.actionSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(actionTitle),
      content:actionSubTitle !=null  ? Text('$actionSubTitle\nAre you sure you want to proceed?') :  const Text('Are you sure you want to proceed?'),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(false); // User pressed NO
          },
          child: const Text('NO'),
        ),
        TextButton.icon(
          icon: const Icon(Icons.add, color: MyColor.red),
          onPressed: () {
            Navigator.of(context).pop(true); // User pressed YES
          },
          label: const Text('YES'),
        ),
      ],
    );
  }
}

Future<void> showConfirmationDialog(
  BuildContext context,
  String actionTitle,
  VoidCallback onConfirmed,
) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) {
      return ConfirmationDialogWidget(
        actionTitle: actionTitle,
        onConfirmed: onConfirmed,

      );
    },
  );

  if (result == true) {
    onConfirmed(); // Call the action if the user pressed YES
  }
}
