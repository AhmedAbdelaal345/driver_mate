abstract class OtpState {}

class OtpInitialState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpSuccessState extends OtpState {
  final String message;
  OtpSuccessState({required this.message});
}

class OtpVerifySuccessState extends OtpState {
  final String message;
  OtpVerifySuccessState({required this.message});
}

class OtpErrorState extends OtpState {
  final String error;
  OtpErrorState({required this.error});
}

class VerifyOtpLoadingState extends OtpState {}

class VerifyOtpSuccessState extends OtpState {
  final String message;

  VerifyOtpSuccessState({required this.message});
}

class ResetPasswordLoadingState extends OtpState {}

class ResetPasswordSuccessState extends OtpState {
  final String message;

  ResetPasswordSuccessState({required this.message});
}
