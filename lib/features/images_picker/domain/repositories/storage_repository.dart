import 'dart:io';

import 'package:book_store/features/images_picker/domain/entities/uploaded_image.dart';

abstract class StorageRepository {
  Future<String?> uploadImage(File imageFile);
  Future<void> saveImageUrlToHistory(String url);
  Stream<List<UploadedImage>> getUploadedImagesHistory();
}
