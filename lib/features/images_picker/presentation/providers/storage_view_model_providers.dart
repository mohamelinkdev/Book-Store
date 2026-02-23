import 'package:book_store/features/images_picker/domain/entities/uploaded_image.dart';
import 'package:book_store/features/images_picker/domain/providers/domain_providers.dart';
import 'package:book_store/features/images_picker/presentation/model/upload_state.dart';
import 'package:book_store/features/images_picker/presentation/view_models/upload_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadViewModelProvider = NotifierProvider<UploadViewModel, UploadState>(
  UploadViewModel.new,
);

final imageHistoryStreamProvider =
    StreamProvider.autoDispose<List<UploadedImage>>((ref) {
      return ref.watch(getHistoryUseCaseProvider).execute();
    });
