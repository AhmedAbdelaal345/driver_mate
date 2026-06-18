import 'package:driver_mate/feature/auth/data/repo/OTP_repo.dart';
import 'package:driver_mate/feature/auth/manager/otp/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitialState());
  OTPRepo otpRepo = OTPRepo();
  void postOTP(
  String email,
  String otp,
  String newPassword,
) async {

  emit(
    ResetPasswordLoadingState(),
  );

  try {

    final result =
        await otpRepo.postOTP(
      email,
      otp,
      newPassword,
    );

    result.fold(

      (error) {

        emit(
          OtpErrorState(
            error: error,
          ),
        );
      },

      (response) {

        emit(
          ResetPasswordSuccessState(
            message: response.message,
          ),
        );
      },
    );

  } catch (e) {

    emit(
      OtpErrorState(
        error: e.toString(),
      ),
    );
  }
}
  void verifyOTP({required String email, required String otp}) async {
    emit(VerifyOtpLoadingState());

    try {
      final result = await otpRepo.postOTPVerify(email, otp);

      result.fold(
        (error) {
          emit(OtpErrorState(error: error));
        },

        (response) {
          emit(VerifyOtpSuccessState(message: response.message));
        },
      );
    } catch (e) {
      emit(OtpErrorState(error: e.toString()));
    }
  }
}
