import 'package:book_store/core/constants/api_constants.dart';
import 'package:book_store/core/exceptions/exceptions.dart';
import 'package:book_store/features/books/data/model/book.dart';
import 'package:book_store/features/books/data/repository/books_repository.dart';
import 'package:book_store/features/books/presentation/models/book_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksViewModel extends Notifier<BooksListState> {
  int _page = 0;
  String _query = ApiConstants.defaultSearch;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  List<Book> _books = [];

  @override
  BooksListState build() {
    loadBooks(reset: true);
    return Loading();
  }

  Future<void> loadBooks({bool reset = false}) async {
    if (_isLoadingMore) return;
    if (!_hasMore && !reset) return;

    _isLoadingMore = true;

    if (reset) {
      _page = 0;
      _hasMore = true;
      _books = [];
      state = Loading(hasMore: _hasMore);
    }

    try {
      final repo = BooksRepository();

      final books = await repo.getBooks(query: _query, page: _page);

      if (books.isEmpty) {
        _hasMore = false;

        if (reset && _books.isEmpty) {
          state = NoDataError();
          _isLoadingMore = false;
          return;
        }
      }

      _page++;
      _books.addAll(books);

      state = Success(_books, hasMore: _hasMore);
    } on NetworkException catch (e) {
      if (reset) {
        state = Failure('Network error', hasMore: _hasMore);
      } else {
        state = Success(_books, hasMore: _hasMore, paginationError: 'Network error');
      }
    } on ServerException catch (e) {
      if (reset) {
        state = Failure('Server error', hasMore: _hasMore);
      } else {
        state = Success(_books, hasMore: _hasMore, paginationError: 'Server error');
      }
    } on TimeoutException {
      final message = 'Request timed out';
      if (reset) {
        state = Failure(message, hasMore: _hasMore);
      } else {
        state = Success(_books, hasMore: _hasMore, paginationError: message);
      }
    } on FormatException catch (e) {
      if (reset) {
        state = Failure('Data parsing error', hasMore: _hasMore);
      } else {
        state = Success(_books, hasMore: _hasMore, paginationError: 'Data parsing error');
      }
    } catch (e, stackTrace) {
      final message = 'An unexpected error occurred';
      if (reset) {
        state = Failure(message, hasMore: _hasMore);
      } else {
        state = Success(_books, hasMore: _hasMore, paginationError: message);
      }
    }

    _isLoadingMore = false;
  }

  void search(String query) {
    _query = query;
    loadBooks(reset: true);
  }

  Future<void> refresh() async {
    await loadBooks(reset: true);
  }
}
