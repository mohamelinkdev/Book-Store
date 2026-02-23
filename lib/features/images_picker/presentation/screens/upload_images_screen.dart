import 'dart:io';
import 'package:book_store/core/constants/values_manager.dart';
import 'package:book_store/core/constants/font_manger.dart';
import 'package:book_store/features/images_picker/presentation/providers/storage_view_model_providers.dart';
import 'package:book_store/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagesScreen extends ConsumerWidget {
  const UploadImagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadState = ref.watch(uploadViewModelProvider);
    final notifier = ref.read(uploadViewModelProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.newUpload),
        actions: [
          IconButton(
            icon: const Icon(Icons.photo_library),
            onPressed: uploadState.isUploading
                ? null
                : () async {
                    final picker = ImagePicker();
                    final pickedFiles = await picker.pickMultiImage();
                    if (pickedFiles.isNotEmpty) {
                      final files = pickedFiles
                          .map((xFile) => File(xFile.path))
                          .toList();
                      notifier.addFiles(files);
                    }
                  },
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: uploadState.isUploading
                ? null
                : () async {
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (pickedFile != null) {
                      notifier.addFile(File(pickedFile.path));
                    }
                  },
          ),
        ],
      ),
      body: uploadState.selectedLocalFiles.isEmpty
          ? Center(child: Text(l10n.useIconsToPickImages))
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSize.s8,
                          mainAxisSpacing: AppSize.s8,
                        ),
                    itemCount: uploadState.selectedLocalFiles.length,
                    itemBuilder: (context, index) {
                      final file = uploadState.selectedLocalFiles[index];
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s8),
                              child: Image.file(file, fit: BoxFit.cover),
                            ),
                          ),
                          if (!uploadState.isUploading)
                            Positioned(
                              top: AppSize.s4,
                              right: AppSize.s4,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: AppSize.s32,
                                ),
                                onPressed: () => notifier.removeLocalFile(file),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: SizedBox(
                      width: double.infinity,
                      height: AppSize.s50,
                      child: ElevatedButton(
                        onPressed: uploadState.isUploading
                            ? null
                            : () async {
                                final success = await notifier
                                    .uploadAllSelected();
                                if (success && context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(l10n.uploadComplete),
                                    ),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                        child: uploadState.isUploading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                l10n.uploadAllSelectedImages,
                                style: const TextStyle(fontSize: FontSize.s16),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
