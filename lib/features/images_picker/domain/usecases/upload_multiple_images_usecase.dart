import 'dart:io';

import 'package:book_store/features/images_picker/domain/repositories/storage_repository.dart';

class UploadMultipleImagesUseCase {
  final StorageRepository repository;
  UploadMultipleImagesUseCase(this.repository);

  Future<void> execute(List<File> filesToUpload) async {
    for (File file in filesToUpload) {
      final url = await repository.uploadImage(file);
      if (url != null) {
        await repository.saveImageUrlToHistory(url);
      }
    }
  }
}
