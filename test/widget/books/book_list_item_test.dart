import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:book_store/features/books/data/model/book.dart';
import 'package:book_store/features/books/presentation/widgets/book_list_item.dart';

void main() {
  testWidgets('BookListItem shows book title and author', (tester) async {
    const book = Book(
      id: '1',
      title: 'Book Title',
      author: 'Book Author',
      thumbnail: '',
      description: '',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BookListItem(book: book),
        ),
      ),
    );

    expect(find.text('Book Title'), findsOneWidget);
    expect(find.text('Book Author'), findsOneWidget);
  });
}
