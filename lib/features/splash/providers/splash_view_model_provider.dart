import 'package:book_store/features/splash/model/splash_state.dart';
import 'package:book_store/features/splash/splash_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewModelProvider = NotifierProvider<SplashViewModel, SplashStatus>(
  SplashViewModel.new,
);
