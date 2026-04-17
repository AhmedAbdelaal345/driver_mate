import 'package:driver_mate/feature/profile/data/repo/change_password_repo.dart';
import 'package:driver_mate/feature/profile/manager/change_password_manager/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitialState());
  ChangePasswordRepo changePasswordRepo = ChangePasswordRepo();
  void changePassword(String oldPassword, String newPassword) async {
    emit(ChangePasswordLoadingState());
    final result = await changePasswordRepo.changePassword(
      oldPassword,
      newPassword,
    );
    result.fold(
      (errorMessage) => emit(ChangePasswordErrorState(errorMessage)),
      (response) => emit(ChangePasswordSuccessState(response.message)),
    );
  }
}
