import 'package:book_store/book_store_app.dart';
import 'package:book_store/core/constants/hive_constants.dart';
import 'package:book_store/features/books/data/model/book.dart';
import 'package:book_store/features/books/data/data_sources/book_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();

  Hive.registerAdapter(BookAdapter());

  await Hive.openBox<Book>(HiveConstants.booksBox);

  runApp(const ProviderScope(child: BookStoreApp()));
}
