import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showAwesomeDialog(
    BuildContext context, String? title, String? description, Widget? screen) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.info,
    animType: AnimType.rightSlide,
    title: title,
    desc: description,
    btnCancelOnPress: () {},
    btnOkOnPress: () {},
  ).show();
}

void showDialogWithGetX(String message) {
  Get.dialog(
    SizedBox(
      child: AlertDialog(
        title: const Text('تنبيه'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('اغلاق'),
          ),
        ],
      ),
    ),
  );
}
