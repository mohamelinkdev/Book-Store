import 'package:book_store/core/constants/values_manager.dart';
import 'package:book_store/features/books/data/model/book.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final bool isBookmarked;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onTap;

  const BookListItem({
    super.key,
    required this.book,
    this.isBookmarked = false,
    this.onBookmarkTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildThumbnail(),
      title: Text(
        book.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        book.author,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: Icon(
          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
          color: isBookmarked ? Theme.of(context).colorScheme.primary : null,
        ),
        onPressed: onBookmarkTap,
      ),
      onTap: onTap,
    );
  }

  Widget? _buildThumbnail() {
    if (book.thumbnail.isEmpty) {
      return const SizedBox(
        width: AppSize.s50,
        child: Icon(Icons.book, size: AppSize.s32),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.s4),
      child: Image.network(
        book.thumbnail,
        width: AppSize.s50,
        height: AppSize.s75,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox(
            width: AppSize.s50,
            child: Icon(Icons.broken_image, size: AppSize.s32),
          );
        },
      ),
    );
  }
}
