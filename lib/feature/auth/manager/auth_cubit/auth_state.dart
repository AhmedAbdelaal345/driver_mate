abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterAuthLoading extends AuthState {}

class RegisterAuthSuccess extends AuthState {}

class RegisterAuthFailure extends AuthState {
  final String errorMessage;
  RegisterAuthFailure(this.errorMessage);
}

class LoginAuthLoading extends AuthState {}

class LoginAuthSuccess extends AuthState {}

class LoginAuthFailure extends AuthState {
  final String errorMessage;
  LoginAuthFailure(this.errorMessage);
}
