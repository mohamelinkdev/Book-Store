import 'package:book_store/features/books/data/model/book.dart';

abstract class BooksListState {
  final bool hasMore;

  BooksListState({this.hasMore = true});
}

class Loading extends BooksListState {
  Loading({super.hasMore});
}

class NoDataError extends BooksListState {
  NoDataError() : super(hasMore: false);
}

class Success extends BooksListState {
  final List<Book> books;
  final String? paginationError;

  Success(this.books, {super.hasMore, this.paginationError});

  Success clearPaginationError() => Success(books, hasMore: hasMore, paginationError: null);
}

class Failure extends BooksListState {
  final String errorMessage;

  Failure(this.errorMessage, {super.hasMore});
}
