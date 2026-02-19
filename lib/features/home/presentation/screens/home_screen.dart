import 'package:book_store/core/constants/app_strings.dart';
import 'package:book_store/core/theme/theme_mode_provider.dart';
import 'package:book_store/features/books/presentation/screens/bookmark_screen.dart';
import 'package:book_store/features/books/presentation/screens/books_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _index = 0;

  final _pages = const [BooksScreen(), BookMarkScreen()];

  void _toggleThemeMode() {
    ref.read(themeModeProvider.notifier).toggle();
  }

  IconData _themeIcon(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => Icons.brightness_auto,
      ThemeMode.light => Icons.light_mode,
      ThemeMode.dark => Icons.dark_mode,
    };
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_index == 0 ? AppStrings.books : AppStrings.bookmarks),
        actions: [
          IconButton(
            icon: Icon(_themeIcon(themeMode)),
            onPressed: _toggleThemeMode,
          ),
        ],
      ),
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() => _index = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: AppStrings.books,
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: AppStrings.bookmarks,
          ),
        ],
      ),
    );
  }
}
