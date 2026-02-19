import 'package:book_store/features/books/data/model/book.dart';
import 'package:book_store/features/books/data/repository/books_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarkedBooksViewModel extends Notifier<List<Book>> {
  @override
  List<Book> build() {
    final repo = BooksRepository();
    return repo.getBookmarks();
  }

  void toggle(Book book) async {
    final repo = BooksRepository();
    await repo.toggleBookmark(book);
    state = repo.getBookmarks();
  }
}
