class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  LoginState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });
}
