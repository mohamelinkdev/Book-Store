import 'package:book_store/core/constants/values_manager.dart';
import 'package:book_store/core/utils/app_loader.dart';
import 'package:book_store/core/utils/app_validator.dart';
import 'package:book_store/core/widgets/app_button.dart';
import 'package:book_store/core/widgets/app_text_form_field.dart';
import 'package:book_store/features/auth/presentation/providers/register_view_model_provider.dart';
import 'package:book_store/features/auth/presentation/screens/login_screen.dart';
import 'package:book_store/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
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
    final l10n = AppLocalizations.of(context)!;
    ref.listen(registerViewModelProvider, (previous, next) {
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
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextFormField(
            controller: emailController,
            labelText: l10n.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.enterEmail;
              }
              if (!AppValidator.isEmailValid(value)) {
                return l10n.invalidEmail;
              }
              return null;
            },
          ),

          const SizedBox(height: AppSize.s20),

          AppTextFormField(
            controller: passwordController,
            labelText: l10n.password,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.enterPassword;
              }
              if (!AppValidator.isPasswordValid(value.trim())) {
                return l10n.passwordMinLength;
              }
              return null;
            },
          ),

          const SizedBox(height: AppSize.s20),

          AppButton(
            text: l10n.register,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ref
                    .read(registerViewModelProvider.notifier)
                    .register(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
              }
            },
          ),

          const SizedBox(height: AppSize.s20),

          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
            child: Text(l10n.alreadyHaveAccount),
          ),
        ],
      ),
    );
  }
}
