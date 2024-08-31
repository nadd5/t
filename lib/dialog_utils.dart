//import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context,
      required String loadingLabel,
      bool barrierDismissible = true}) {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 8),
                Text(loadingLabel,
                    style: Theme.of(context).textTheme.bodyMedium)
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context,
      required String contents,
      String title = 'Title',
      String? posActionName,
      Function? posAction,
      String? negActionName,
      Function? negAction}) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionName),
        ),
      );
    }
    if (negActionName != null) {
      actions.add(ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            /*if (negAction != null) {
              negAction.call();
            }*/
            negAction?.call();
          },
          child: Text(negActionName)));
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Text(
                contents,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              title: Text(title, style: Theme.of(context).textTheme.bodySmall),
              actions: actions);
        });
  }
}
