import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/profile/data/model/edit_profile_model.dart';
import 'package:driver_mate/feature/profile/data/repo/edit_profile_repo.dart';
import 'package:driver_mate/feature/profile/manager/edit_profile_manager/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepo repo;
  String? selectedImage;

  EditProfileCubit({required this.repo}) : super(InitEditProfile()) {
    getUserData();
  }

  Future<void> getUserData() async {
    emit(LoadingEditProfile());
    try {
      final EditProfileModel data = await repo.getProfile();
      emit(SuccessEditProfile(message: AppConstants.fetchSuccess, data: data));
    } catch (e) {
      emit(ErrorEditProfile(error: e.toString()));
    }
  }

  Future<void> changeUser({
    required String fullName,
    required String phoneNumber,
    required String image,
    // email removed — read-only field, cannot be changed
  }) async {
    emit(LoadingEditProfile());
    try {
      final current = await repo.getProfile();

      final EditProfileModel updated = await repo.changeProfile(
        fullName: fullName,
        phoneNumber: phoneNumber,
        image: image,
        accessToken: current.accessToken,
      );

      selectedImage = null;

      emit(
        UpdateProfileSuccess(
          message: AppConstants.changedSuccefuly,
          data: updated,
        ),
      );
    } catch (e) {
      emit(ErrorEditProfile(error: e.toString()));
    }
  }

  void updateImage(String path) {
    selectedImage = path;
    emit(EditProfileImageChanged(path));
  }
}
