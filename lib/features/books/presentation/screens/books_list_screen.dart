import 'package:book_store/core/constants/app_strings.dart';
import 'package:book_store/core/widgets/empty_state.dart';
import 'package:book_store/core/widgets/error_state.dart';
import 'package:book_store/core/widgets/loading_state.dart';
import 'package:book_store/core/widgets/search_bar.dart';
import 'package:book_store/features/books/data/model/book.dart';
import 'package:book_store/features/books/presentation/models/book_list_state.dart';
import 'package:book_store/features/books/presentation/providers/books_list_view_mode_provider.dart';
import 'package:book_store/features/books/presentation/providers/books_marked_view_model_provider.dart';
import 'package:book_store/features/books/presentation/screens/book_details.dart';
import 'package:book_store/features/books/presentation/widgets/books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BooksScreen extends ConsumerStatefulWidget {
  const BooksScreen({super.key});

  @override
  ConsumerState<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends ConsumerState<BooksScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(booksViewModelProvider.notifier).loadBooks();
    }
  }

  void _onSearch(String query) {
    ref.read(booksViewModelProvider.notifier).search(query);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booksState = ref.watch(booksViewModelProvider);
    final markedBooks = ref.watch(markedBooksViewModelProvider);

    return Column(
      children: [
        AppSearchBar(onSearch: _onSearch, hintText: AppStrings.searchBooksHint),
        Expanded(child: _buildContent(booksState, markedBooks)),
      ],
    );
  }

  Widget _buildContent(BooksListState state, List<Book> markedBooks) {
    if (state is Loading) {
      return const LoadingState();
    }

    if (state is Failure) {
      return ErrorState(
        message: state.errorMessage,
        onRetry: () => ref.read(booksViewModelProvider.notifier).refresh(),
      );
    }

    if (state is NoDataError) {
      return EmptyState(
        message: AppStrings.noBooksFound,
        icon: Icons.search_off,
      );
    }

    if (state is Success) {
      return BooksListView(
        books: state.books,
        hasMore: state.hasMore,
        paginationError: state.paginationError,
        scrollController: _scrollController,
        onRefresh: () => ref.read(booksViewModelProvider.notifier).refresh(),
        onRetry: state.paginationError != null
            ? () => ref.read(booksViewModelProvider.notifier).loadBooks()
            : null,
        onBookmarkTap: (book) =>
            ref.read(markedBooksViewModelProvider.notifier).toggle(book),
        isBookmarked: (id) => markedBooks.any((b) => b.id == id),
        onBookTap: (book) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => BookDetailsScreen(book: book)),
          );
        },
      );
    }

    return const SizedBox();
  }
}
