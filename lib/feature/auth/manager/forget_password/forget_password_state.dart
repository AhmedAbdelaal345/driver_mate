class ForgetPasswordState {}
class ForgetPasswordInitialState extends ForgetPasswordState {}
class ForgetPasswordLoadingState extends ForgetPasswordState {}
class ForgetPasswordSuccessState extends ForgetPasswordState {
  final String message;
  ForgetPasswordSuccessState({required this.message});
}
class ForgetPasswordErrorState extends ForgetPasswordState {
  final String error;
  ForgetPasswordErrorState({required this.error});
}