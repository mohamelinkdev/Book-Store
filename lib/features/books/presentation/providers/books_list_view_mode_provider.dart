import 'package:book_store/features/books/presentation/models/book_list_state.dart';
import 'package:book_store/features/books/presentation/view_model/book_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final booksViewModelProvider =
    NotifierProvider<BooksViewModel, BooksListState>(
      BooksViewModel.new,
    );
