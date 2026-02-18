import 'package:book_store/core/constants/app_strings.dart';
import 'package:book_store/core/constants/values_manager.dart';
import 'package:book_store/features/books/data/model/book.dart';
import 'package:book_store/features/books/presentation/widgets/book_list_item.dart';
import 'package:flutter/material.dart';

class BooksListView extends StatelessWidget {
  final List<Book> books;
  final bool hasMore;
  final String? paginationError;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final VoidCallback? onRetry;
  final void Function(Book) onBookmarkTap;
  final bool Function(String) isBookmarked;

  const BooksListView({
    super.key,
    required this.books,
    required this.hasMore,
    this.paginationError,
    required this.scrollController,
    required this.onRefresh,
    this.onRetry,
    required this.onBookmarkTap,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: scrollController,
        itemCount: books.length + 1,
        itemBuilder: (context, index) {
          if (index == books.length) {
            return _buildBottomWidget();
          }

          final book = books[index];
          return BookListItem(
            book: book,
            isBookmarked: isBookmarked(book.id),
            onBookmarkTap: () => onBookmarkTap(book),
            onTap: () {},
          );
        },
      ),
    );
  }

  Widget _buildBottomWidget() {
    if (paginationError != null) {
      return Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            Text(
              paginationError!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSize.s8),
            if (onRetry != null)
              ElevatedButton(
                onPressed: onRetry,
                child: const Text(AppStrings.retry),
              ),
          ],
        ),
      );
    }

    if (!hasMore) {
      return const SizedBox();
    }

    return const Padding(
      padding: EdgeInsets.all(AppPadding.p16),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
