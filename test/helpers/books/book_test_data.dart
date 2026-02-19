import 'package:book_store/features/books/data/model/book.dart';

Book buildBook({
  String id = '1',
  String title = 'Test Book',
  String author = 'Test Author',
  String thumbnail = '',
  String description = 'Test Description',
}) {
  return Book(
    id: id,
    title: title,
    author: author,
    thumbnail: thumbnail,
    description: description,
  );
}

List<Book> buildBooks(int count, {int start = 1}) {
  return List.generate(
    count,
    (i) => buildBook(id: '${start + i}', title: 'Book ${start + i}'),
  );
}
