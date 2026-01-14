import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      emit(SplashAnimationStart());
      Future.delayed(const Duration(seconds: 4), () {
        emit(SplashNavigate());
      });
    });
  }
}
