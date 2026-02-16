import 'package:book_store/core/constants/app_strings.dart';
import 'package:book_store/core/constants/values_manager.dart';
import 'package:book_store/core/utils/app_loader.dart';
import 'package:book_store/core/utils/app_validator.dart';
import 'package:book_store/features/auth/presentation/providers/login_view_model_provider.dart';
import 'package:book_store/features/auth/presentation/screens/register_screen.dart';
import 'package:book_store/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginViewModelProvider, (previous, next) {
      if (next.isLoading) {
        AppLoader.show(context);
      } else if (previous != null && previous.isLoading) {
        AppLoader.hide(context);
      }

      if (next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }

      if (next.isSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: AppStrings.email,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.enterEmail;
              }
              if (!AppValidator.isEmailValid(value.trim())) {
                return AppStrings.invalidEmail;
              }
              return null;
            },
          ),

          const SizedBox(height: AppSize.s20),

          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: AppStrings.password,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.enterPassword;
              }
              if (value.length < 6) {
                return AppStrings.passwordMinLength;
              }
              return null;
            },
          ),

          const SizedBox(height: AppSize.s20),

          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ref
                    .read(loginViewModelProvider.notifier)
                    .login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
              }
            },
            child: const Text(AppStrings.login),
          ),

          const SizedBox(height: AppSize.s20),

          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const RegisterScreen()),
              );
            },
            child: const Text(AppStrings.dontHaveAccount),
          ),
        ],
      ),
    );
  }
}
