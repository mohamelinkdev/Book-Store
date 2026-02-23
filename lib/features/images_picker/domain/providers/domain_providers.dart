import 'package:book_store/features/images_picker/data/providers/data_providers.dart';
import 'package:book_store/features/images_picker/domain/usecases/get_image_history_usecase.dart';
import 'package:book_store/features/images_picker/domain/usecases/upload_multiple_images_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getHistoryUseCaseProvider = Provider<GetImageHistoryUseCase>(
  (ref) => GetImageHistoryUseCase(ref.watch(storageRepositoryProvider)),
);

final uploadMultipleImagesUseCaseProvider =
    Provider<UploadMultipleImagesUseCase>(
      (ref) =>
          UploadMultipleImagesUseCase(ref.watch(storageRepositoryProvider)),
    );
