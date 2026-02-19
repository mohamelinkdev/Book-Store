import 'package:book_store/features/books/data/model/book.dart';
import 'package:book_store/features/books/presentation/view_model/books_book_marked_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final markedBooksViewModelProvider =
    NotifierProvider<MarkedBooksViewModel, List<Book>>(
      MarkedBooksViewModel.new,
    );
