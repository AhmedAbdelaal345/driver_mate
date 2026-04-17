abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterAuthLoading extends AuthState {}

class RegisterAuthSuccess extends AuthState {
  final String message;
  RegisterAuthSuccess({this.message = "Registration Successful"});
}

class RegisterAuthFailure extends AuthState {
  final String errorMessage;
  RegisterAuthFailure(this.errorMessage);
}

class LoginAuthLoading extends AuthState {}

class LoginAuthSuccess extends AuthState {
  final String message;
  LoginAuthSuccess({required this.message});
}

class LoginAuthFailure extends AuthState {
  final String errorMessage;
  LoginAuthFailure(this.errorMessage);
}
