import 'package:book_store/core/constants/app_assets.dart';
import 'package:book_store/core/constants/app_strings.dart';
import 'package:book_store/core/constants/values_manager.dart';
import 'package:book_store/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.login)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p20),
          child: Column(
            children: [
              Image.asset(AppAssets.bookIcon, height: AppSize.s200),
              const SizedBox(height: AppSize.s20),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
