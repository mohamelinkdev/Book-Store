import 'dart:io';

class UploadState {
  final bool isUploading;
  final List<File> selectedLocalFiles;
  UploadState({this.isUploading = false, this.selectedLocalFiles = const []});
  UploadState copyWith({bool? isUploading, List<File>? selectedLocalFiles}) {
    return UploadState(
      isUploading: isUploading ?? this.isUploading,
      selectedLocalFiles: selectedLocalFiles ?? this.selectedLocalFiles,
    );
  }
}
