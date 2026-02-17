import 'package:book_store/core/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';

class AppLoader {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingDialog(),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (context.mounted) {
        FocusScope.of(context).unfocus();
      }
    });
  }
}
