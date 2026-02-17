import 'package:book_store/core/constants/app_strings.dart';
import 'package:book_store/features/auth/presentation/models/login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/auth_repository.dart';

class LoginViewModel extends Notifier<LoginState> {
  final AuthRepository _repository = AuthRepository();

  @override
  LoginState build() {
    return LoginState();
  }

  Future<void> login(String email, String password) async {
    state = LoginState(isLoading: true);

    try {
      await _repository.login(email: email, password: password);
      state = LoginState(isSuccess: true);
    } on FirebaseAuthException catch (e) {
      state = LoginState(errorMessage: e.message);
    } catch (e) {
      state = LoginState(errorMessage: AppStrings.generalErrorMessage);
    }
  }
}
