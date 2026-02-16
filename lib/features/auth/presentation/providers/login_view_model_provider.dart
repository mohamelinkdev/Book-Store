import 'package:book_store/features/auth/presentation/models/login_state.dart';
import 'package:book_store/features/auth/presentation/view_model/login_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginViewModelProvider = NotifierProvider<LoginViewModel, LoginState>(
  LoginViewModel.new,
);
