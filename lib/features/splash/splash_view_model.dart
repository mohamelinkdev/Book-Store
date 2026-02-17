import 'package:book_store/features/splash/model/splash_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashViewModel extends Notifier<SplashStatus> {
  @override
  SplashStatus build() {
    return SplashStatus.initial;
  }

  Future<void> checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      state = SplashStatus.authenticated;
    } else {
      state = SplashStatus.unauthenticated;
    }
  }
}
