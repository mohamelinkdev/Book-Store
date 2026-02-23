import 'package:book_store/features/images_picker/domain/entities/uploaded_image.dart';
import 'package:book_store/features/images_picker/domain/repositories/storage_repository.dart';

class GetImageHistoryUseCase {
  final StorageRepository repository;
  GetImageHistoryUseCase(this.repository);

  Stream<List<UploadedImage>> execute() {
    return repository.getUploadedImagesHistory();
  }
}
