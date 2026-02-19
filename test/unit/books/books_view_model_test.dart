import 'package:book_store/core/exceptions/exceptions.dart';
import 'package:book_store/features/books/presentation/models/book_list_state.dart';
import 'package:book_store/features/books/presentation/providers/books_list_view_mode_provider.dart';
import 'package:book_store/features/books/presentation/providers/books_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/books/book_test_data.dart';
import '../../helpers/books/fake_books_repository.dart';

void main() {
  test('loads books then keeps them on pagination error', () async {
    final fakeRepo = FakeBooksRepository(
      onGetBooks: (query, page) async {
        if (page == 0) return buildBooks(2);
        throw NetworkException('No internet');
      },
    );

    final container = ProviderContainer(
      overrides: [
        booksRepositoryProvider.overrideWithValue(fakeRepo),
      ],
    );
    addTearDown(container.dispose);

    await container.read(booksViewModelProvider.notifier).loadBooks(reset: true);

    final stateAfterFirstLoad = container.read(booksViewModelProvider) as Success;
    expect(stateAfterFirstLoad.books.length, 2);

    await container.read(booksViewModelProvider.notifier).loadBooks(reset: false);

    final stateAfterPaging = container.read(booksViewModelProvider) as Success;
    expect(stateAfterPaging.books.length, 2);
    expect(stateAfterPaging.paginationError, isNotNull);
  });
}
