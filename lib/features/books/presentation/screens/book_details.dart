import 'package:book_store/features/books/data/model/book.dart';
import 'package:book_store/features/books/presentation/providers/books_marked_view_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookDetailsScreen extends ConsumerWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBookmarked = ref.watch(
      markedBooksViewModelProvider.select(
        (books) => books.any((b) => b.id == book.id),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              ref.read(markedBooksViewModelProvider.notifier).toggle(book);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book.thumbnail),
            const SizedBox(height: 16),
            Text(
              book.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(book.author),
            const SizedBox(height: 16),
            Text(book.description),
          ],
        ),
      ),
    );
  }
}
