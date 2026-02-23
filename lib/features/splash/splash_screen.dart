import 'package:book_store/core/constants/app_assets.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/features/auth/presentation/screens/login_screen.dart';
import 'package:book_store/features/home/presentation/screens/home_screen.dart';
import 'package:book_store/features/splash/model/splash_state.dart';
import 'package:book_store/features/splash/providers/splash_view_model_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(splashViewModelProvider.notifier).checkAuth();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SplashStatus>(splashViewModelProvider, (previous, next) {
      if (next == SplashStatus.authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else if (next == SplashStatus.unauthenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Image.asset(
          AppAssets.bookIcon,
          height: 100,
          width: 100,
          color: Colors.white,
        ),
      ),
    );
  }
}
