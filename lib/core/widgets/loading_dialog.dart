import 'package:book_store/core/constants/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:book_store/l10n/app_localizations.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: AppSize.s20),
            Text(AppLocalizations.of(context)!.loading),
          ],
        ),
      ),
    );
  }
}
