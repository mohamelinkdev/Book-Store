import 'dart:io';
import 'package:book_store/features/images_picker/presentation/model/upload_state.dart';
import 'package:book_store/features/images_picker/domain/providers/domain_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadViewModel extends Notifier<UploadState> {
  @override
  UploadState build() => UploadState();

  void addFiles(List<File> files) {
    if (files.isNotEmpty) {
      state = state.copyWith(
        selectedLocalFiles: [...state.selectedLocalFiles, ...files],
      );
    }
  }

  void addFile(File file) {
    state = state.copyWith(
      selectedLocalFiles: [...state.selectedLocalFiles, file],
    );
  }

  void removeLocalFile(File fileToRemove) {
    final updatedList = state.selectedLocalFiles
        .where((file) => file.path != fileToRemove.path)
        .toList();
    state = state.copyWith(selectedLocalFiles: updatedList);
  }

  Future<bool> uploadAllSelected() async {
    if (state.selectedLocalFiles.isEmpty) return false;

    state = state.copyWith(isUploading: true);

    try {
      final useCase = ref.read(uploadMultipleImagesUseCaseProvider);
      await useCase.execute(state.selectedLocalFiles);
      state = UploadState(isUploading: false, selectedLocalFiles: []);
      return true;
    } catch (e) {
      state = state.copyWith(isUploading: false);
      return false;
    }
  }
}
