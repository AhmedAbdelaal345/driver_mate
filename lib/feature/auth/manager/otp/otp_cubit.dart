import 'package:driver_mate/feature/auth/data/repo/OTP_repo.dart';
import 'package:driver_mate/feature/auth/manager/otp/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitialState());
  OTPRepo otpRepo = OTPRepo();
  void postOTP(String email, String otp, String newPassword) async {
    emit(OtpLoadingState());
    try {
      final result = await otpRepo.postOTP(email, otp, newPassword);
      result.fold(
        (error) => emit(OtpErrorState(error: error)),
        (response) => emit(OtpSuccessState(message: response.message)),
      );
    } catch (e) {
      emit(OtpErrorState(error: e.toString()));
    }
  }
}
