import 'package:driver_mate/core/local/shared_key.dart';
import 'package:driver_mate/feature/splach/manager/cubit/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(SplashAnimationStart());

      Future.delayed(const Duration(seconds: 3), () async {
        SharedPreferences pref = await SharedPreferences.getInstance();
        final String? profile =  pref.getString(SharedKey.accessToken);

        if (profile != null && profile.trim().isNotEmpty) {
          emit(SplashNavigateToHome());
        } else {
          emit(SplashNavigateToLogin());
        }
      });
    });
  }
}
