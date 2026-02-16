import 'package:book_store/features/auth/presentation/models/register_state.dart';
import 'package:book_store/features/auth/presentation/view_model/register_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerViewModelProvider =
    NotifierProvider<RegisterViewModel, RegisterState>(RegisterViewModel.new);
