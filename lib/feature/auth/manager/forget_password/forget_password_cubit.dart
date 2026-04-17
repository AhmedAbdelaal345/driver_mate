import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/network/api_response.dart';
import 'package:driver_mate/feature/auth/data/repo/forget_password_repo.dart';
import 'package:driver_mate/feature/auth/manager/forget_password/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());
  void forgetPassword(String email) async {
    emit(ForgetPasswordLoadingState());
    final ForgetPasswordRepo repo = ForgetPasswordRepo();
    try {
      final Either<String, ApiResponse> result = await repo.sendEmail(email);
      result.fold((error) => emit(ForgetPasswordErrorState(error: error)), (
        response,
      ) {
        emit(ForgetPasswordSuccessState(message: response.message));
      });
    } catch (e) {
      // On error
      emit(ForgetPasswordErrorState(error: e.toString()));
    }
  }
}
