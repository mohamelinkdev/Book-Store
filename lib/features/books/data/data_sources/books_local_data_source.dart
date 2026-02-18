import 'package:book_store/core/constants/hive_constants.dart';
import 'package:book_store/features/books/data/model/book.dart';
import 'package:hive/hive.dart';

class BooksLocalDataSource {
  final Box<Book> box = Hive.box<Book>(HiveConstants.booksBox);

  BooksLocalDataSource();

  Future<void> saveBookmark(Book book) async {
    await box.put(book.id, book);
  }

  Future<void> removeBookmark(String id) async {
    await box.delete(id);
  }

  List<Book> getBookmarks() {
    return box.values.toList();
  }

  bool isBookmarked(String id) {
    return box.containsKey(id);
  }
}
