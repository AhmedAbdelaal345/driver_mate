import 'package:driver_mate/feature/profile/data/model/edit_profile_model.dart';

sealed class EditProfileState {}

class InitEditProfile extends EditProfileState {}

class LoadingEditProfile extends EditProfileState {}

class SuccessEditProfile extends EditProfileState {
  final String message;
  final EditProfileModel data;

  SuccessEditProfile({
    required this.message,
    required this.data,
  });
}

class UpdateProfileSuccess extends EditProfileState {
  final String message;
  final EditProfileModel data;

  UpdateProfileSuccess({
    required this.message,
    required this.data,
  });
}

class ErrorEditProfile extends EditProfileState {
  final String error;
  ErrorEditProfile({required this.error});
}

class EditProfileImageChanged extends EditProfileState {
  final String path;
  EditProfileImageChanged(this.path);
}