import 'package:book_store/features/books/data/model/book.dart';
import 'package:book_store/features/books/data/repository/books_repository.dart';

class FakeBooksRepository implements BooksRepositoryBase {
  FakeBooksRepository({
    this.onGetBooks,
    List<Book>? initialBookmarks,
  }) : _bookmarks = initialBookmarks ?? [];

  final Future<List<Book>> Function(String query, int page)? onGetBooks;
  final List<Book> _bookmarks;

  @override
  Future<List<Book>> getBooks({required String query, required int page}) async {
    if (onGetBooks != null) {
      return onGetBooks!(query, page);
    }
    return <Book>[];
  }

  @override
  List<Book> getBookmarks() => List.unmodifiable(_bookmarks);

  @override
  bool isBookmarked(String id) => _bookmarks.any((b) => b.id == id);

  @override
  Future<void> toggleBookmark(Book book) async {
    final index = _bookmarks.indexWhere((b) => b.id == book.id);
    if (index >= 0) {
      _bookmarks.removeAt(index);
    } else {
      _bookmarks.add(book);
    }
  }
}
