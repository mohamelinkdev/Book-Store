import 'package:book_store/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.home)),
      body: const Center(
        child: Text(AppStrings.home),
      ),
    );
  }
}
