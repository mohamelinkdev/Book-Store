import 'package:book_store/features/books/data/repository/books_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final booksRepositoryProvider = Provider<BooksRepositoryBase>((ref) {
  return BooksRepository();
});
