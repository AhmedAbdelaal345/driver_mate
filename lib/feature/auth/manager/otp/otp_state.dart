abstract class OtpState {}

class OtpInitialState extends OtpState {}

class OtpLoadingState extends OtpState {}

class OtpSuccessState extends OtpState {
  final String message;
  OtpSuccessState({required this.message});
}

class OtpErrorState extends OtpState {
  final String error;
  OtpErrorState({required this.error});
}
