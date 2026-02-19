import 'package:book_store/features/books/presentation/models/book_list_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/books/book_test_data.dart';

void main() {
  group('BooksListState', () {
    test('NoDataError hasMore is false', () {
      final state = NoDataError();
      expect(state.hasMore, isFalse);
    });

    test('Success clearPaginationError clears paginationError', () {
      final books = buildBooks(2);
      final state = Success(books, hasMore: true, paginationError: 'Network error');

      final cleared = state.clearPaginationError();

      expect(cleared.paginationError, isNull);
      expect(cleared.books.length, equals(2));
      expect(cleared.hasMore, isTrue);
    });
  });
}
