import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/profile/data/model/edit_profile_model.dart';
import 'package:driver_mate/feature/profile/data/repo/edit_profile_repo.dart';
import 'package:driver_mate/feature/profile/manager/edit_profile_manager/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepo repo;
  EditProfileCubit({required this.repo}) : super(InitEditProfile());

  Future<void> changeUser({
    required String fullName,
    required String emailAddress,
    required String image,
    required String phoneNumber,
  }) async {
    emit(LoadingEditProfile());
    try {
      final EditProfileModel data = await repo.changeProfile(
        fullName: fullName,
        emailAddress: emailAddress,
        image: image,
        phoneNumber: phoneNumber,
      );
      repo.saveProfile(
        name: fullName,
        email: emailAddress,
        phone: phoneNumber,
        image: image,
      );
      emit(
        SuccessEditProfile(message: AppConstants.changedSuccefuly, data: data),
      );
    } catch (e) {
      emit(ErrorEditProfile(error: e.toString()));
    }
  }

  Future<void> getUserData() async {
    emit(LoadingEditProfile());
    try {
      final EditProfileModel? data = await repo.getProfile();
      if (data != null) {
        emit(
          SuccessEditProfile(
            message: AppConstants.loadedSuccefully,
            data: data,
          ),
        );
      }
    } catch (e) {
      emit(ErrorEditProfile(error: e.toString()));
    }
  }

  Future<void> loadProfile() async {
    final data = await repo.getProfile();

    if (data != null) {
      emit(
        SuccessEditProfile(message: AppConstants.loadedSuccefully, data: data),
      );
    }
  }
}
