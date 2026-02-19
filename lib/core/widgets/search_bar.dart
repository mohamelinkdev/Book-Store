import 'dart:async';

import 'package:book_store/core/constants/values_manager.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  final String hintText;
  final Duration debounceDuration;

  const AppSearchBar({
    super.key,
    required this.onSearch,
    required this.hintText,
    this.debounceDuration = const Duration(milliseconds: 500),
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(widget.debounceDuration, () {
      widget.onSearch(_controller.text.trim());
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    widget.onSearch('');
                  },
                )
              : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
