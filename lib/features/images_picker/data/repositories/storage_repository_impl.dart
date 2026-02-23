import 'dart:io';

import 'package:book_store/features/images_picker/data/datasources/remote_storage_datasource.dart';
import 'package:book_store/features/images_picker/domain/entities/uploaded_image.dart';
import 'package:book_store/features/images_picker/domain/repositories/storage_repository.dart';

class StorageRepositoryImpl implements StorageRepository {
  final IRemoteStorageDataSource remoteDataSource;
  StorageRepositoryImpl(this.remoteDataSource);

  @override
  Future<String?> uploadImage(File imageFile) =>
      remoteDataSource.uploadToImgBB(imageFile);

  @override
  Future<void> saveImageUrlToHistory(String url) =>
      remoteDataSource.saveUrlToFirestore(url);

  @override
  Stream<List<UploadedImage>> getUploadedImagesHistory() {
    return remoteDataSource.getUrlsStreamFromFirestore().map(
      (urlList) => urlList.map((url) => UploadedImage(url: url)).toList(),
    );
  }
}
