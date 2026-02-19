import 'package:book_store/core/constants/app_strings.dart';
import 'package:book_store/core/constants/values_manager.dart';
import 'package:flutter/material.dart';

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: AppSize.s48,
            ),
            const SizedBox(height: AppSize.s16),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSize.s16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text(AppStrings.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
