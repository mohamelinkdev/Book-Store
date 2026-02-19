class AppValidator {
  static bool isEmailValid(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');
    return emailRegex.hasMatch(value);
  }

  static bool isPasswordValid(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    return value.length >= 6;
  }
}
