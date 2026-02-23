import 'package:book_store/features/images_picker/data/datasources/remote_storage_datasource.dart';
import 'package:book_store/features/images_picker/data/repositories/storage_repository_impl.dart';
import 'package:book_store/features/images_picker/domain/repositories/storage_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final remoteDataSourceProvider = Provider<IRemoteStorageDataSource>(
  (ref) => RemoteStorageDatasource(),
);

final storageRepositoryProvider = Provider<StorageRepository>(
  (ref) => StorageRepositoryImpl(ref.watch(remoteDataSourceProvider)),
);
