import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/feature/profile/data/model/edit_profile_model.dart';
import 'package:driver_mate/feature/profile/data/repo/edit_profile_repo.dart';
import 'package:driver_mate/feature/profile/manager/edit_profile_manager/edit_profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileRepo repo;
  String? selectedImage;

  EditProfileCubit({required this.repo}) : super(InitEditProfile()) {
    getUserData(); // single call — removed duplicate from initState
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
    required String emailAddress,
    required String image,
    required String phoneNumber,
  }) async {
    emit(LoadingEditProfile());
    try {
      final current = await repo.getProfile();

      final EditProfileModel updated = await repo.changeProfile(
        fullName: fullName,
        emailAddress: emailAddress,
        image: image,
        phoneNumber: phoneNumber,
        accessToken: current.accessToken,
      );

      selectedImage = null; // reset picked image after saving

      emit(
        UpdateProfileSuccess(
          message: AppConstants.changedSuccefuly,
          data: updated,
        ),
      );
      // ✅ Removed getUserData() — it would overwrite with stale server data
    } catch (e) {
      emit(ErrorEditProfile(error: e.toString()));
    }
  }

  void updateImage(String path) {
    selectedImage = path;
    emit(EditProfileImageChanged(path));
  }
}
