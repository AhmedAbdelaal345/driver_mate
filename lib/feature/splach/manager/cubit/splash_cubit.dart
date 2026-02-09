import 'package:bloc/bloc.dart';
import 'package:driver_mate/feature/profile/data/repo/edit_profile_repo.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(SplashAnimationStart());
      Future.delayed(const Duration(seconds: 3), () async {
        final profile = await EditProfileRepo.instance.getProfile();
        if (profile != null && profile.fullName.isNotEmpty) {
          emit(SplashNavigateToHome());
        } else {
          emit(SplashNavigateToLogin());
        }
      });
    });
  }
}
