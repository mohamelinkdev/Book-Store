import 'package:book_store/core/constants/values_manager.dart';
import 'package:book_store/features/images_picker/presentation/providers/storage_view_model_providers.dart';
import 'package:book_store/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'upload_images_screen.dart';

class ImageHistoryScreen extends ConsumerWidget {
  const ImageHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsyncValue = ref.watch(imageHistoryStreamProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: historyAsyncValue.when(
        data: (images) {
          if (images.isEmpty) {
            return Center(child: Text(l10n.noImagesFoundInHistory));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(AppPadding.p8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s8),
                child: Image.network(
                  images[index].url,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text(l10n.errorLoadingHistory)),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UploadImagesScreen()),
          );
        },
      ),
    );
  }
}
