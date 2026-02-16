import 'package:book_store/core/constants/app_strings.dart';
import 'package:book_store/features/auth/presentation/models/register_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/auth_repository.dart';

class RegisterViewModel extends Notifier<RegisterState> {
  final AuthRepository _repository = AuthRepository();

  @override
  RegisterState build() {
    return RegisterState();
  }

  Future<void> register(String email, String password) async {
    state = RegisterState(isLoading: true);

    try {
      await _repository.register(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      state = RegisterState(errorMessage: e.message);
    } catch (e) {
      state = RegisterState(errorMessage: AppStrings.generalErrorMessage);
    }

    state = RegisterState(isLoading: false);
  }
}
