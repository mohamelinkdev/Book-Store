import 'package:book_store/core/constants/app_strings.dart';
import 'package:book_store/core/constants/values_manager.dart';
import 'package:book_store/core/utils/app_validator.dart';
import 'package:book_store/core/widgets/app_button.dart';
import 'package:book_store/core/widgets/app_text_form_field.dart';
import 'package:book_store/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextFormField(
            controller: emailController,
            labelText: AppStrings.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.enterEmail;
              }
              if (!AppValidator.isEmailValid(value)) {
                return AppStrings.invalidEmail;
              }
              return null;
            },
          ),

          const SizedBox(height: AppSize.s20),

          AppTextFormField(
            controller: passwordController,
            labelText: AppStrings.password,
            obscureText: true,
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

          AppButton(
            text: AppStrings.login,
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
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
