import 'package:book_store/core/constants/api_constants.dart';
import 'package:book_store/features/books/data/model/book.dart';
import 'package:book_store/features/books/data/data_sources/books_local_data_source.dart';
import 'package:book_store/features/books/data/data_sources/books_remote_data_source.dart';

abstract class BooksRepositoryBase {
  Future<List<Book>> getBooks({
    required String query,
    required int page,
    String? lang,
  });

  Future<void> toggleBookmark(Book book);

  List<Book> getBookmarks();

  bool isBookmarked(String id);
}

class BooksRepository implements BooksRepositoryBase {
  final BooksRemoteDataSource remote = BooksRemoteDataSource();
  final BooksLocalDataSource local = BooksLocalDataSource();

  @override
  Future<List<Book>> getBooks({
    required String query,
    required int page,
    String? lang,
  }) async {
    return await remote.fetchBooks(
      query: query,
      startIndex: page * ApiConstants.bookListPageSize,
      pageSize: ApiConstants.bookListPageSize,
      lang: lang,
    );
  }

  @override
  Future<void> toggleBookmark(Book book) async {
    if (local.isBookmarked(book.id)) {
      await local.removeBookmark(book.id);
    } else {
      await local.saveBookmark(book);
    }
  }

  @override
  List<Book> getBookmarks() => local.getBookmarks();

  @override
  bool isBookmarked(String id) => local.isBookmarked(id);
}
