class RegisterState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  RegisterState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });
}
