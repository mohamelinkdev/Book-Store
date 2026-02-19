import 'package:book_store/core/constants/app_strings.dart';
import 'package:book_store/features/books/presentation/providers/books_marked_view_model_provider.dart';
import 'package:book_store/features/books/presentation/screens/book_details.dart';
import 'package:book_store/features/books/presentation/widgets/book_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookMarkScreen extends ConsumerWidget {
  const BookMarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(markedBooksViewModelProvider);

    if (books.isEmpty) {
      return const Center(child: Text(AppStrings.noBookmarks));
    }
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (_, index) {
        final book = books[index];

        return BookListItem(
          book: book,
          isBookmarked: true,
          onBookmarkTap:
              () =>
                  ref.read(markedBooksViewModelProvider.notifier).toggle(book),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BookDetailsScreen(book: book)),
            );
          },
        );
      },
    );
  }
}
