abstract class ChangePasswordState {}
class ChangePasswordInitialState extends ChangePasswordState {}
class ChangePasswordLoadingState extends ChangePasswordState {}
class ChangePasswordSuccessState extends ChangePasswordState {
  final String successMessage;
  ChangePasswordSuccessState(this.successMessage);
}
class ChangePasswordErrorState extends ChangePasswordState {
  final String errorMessage;
  ChangePasswordErrorState(this.errorMessage);
}