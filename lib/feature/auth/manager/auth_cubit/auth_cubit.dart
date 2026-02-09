import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/network/api_response.dart';
import 'package:driver_mate/feature/auth/data/model/auth_model.dart';
import 'package:driver_mate/feature/auth/data/repo/auth_repo.dart';
import 'package:driver_mate/feature/auth/manager/auth_cubit/auth_state.dart';
import 'package:driver_mate/feature/profile/data/repo/edit_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepo authRepo = AuthRepo();
  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);
  final GlobalKey<FormState> registerFormKey = GlobalKey();
  final GlobalKey<FormState> loginFormKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  DateTime? lastBackPressed;
  bool isAgreed = false;
  void onRegisterPress() async {
    emit(RegisterAuthLoading());
    Either<String, String> result = await authRepo.register(
      user: UserModel(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    result.fold((String error) => emit(RegisterAuthFailure(error)), (success) {
      EditProfileRepo.instance.saveProfile(
        name: nameController.text,
        email: emailController.text,
        phone: "01000000000",
        image: "https://cdn-icons-png.flaticon.com/512/149/149071.png",
      );
      emit(RegisterAuthSuccess(message: success));
    });
  }

  void clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void toggleAgree(bool value) {
    isAgreed = value;
    emit(AuthInitial()); // just to trigger UI rebuild
  }

  void resetState() {
    emit(AuthInitial());
  }

  void onLoginPress() async {
    emit(LoginAuthLoading());
    Either<ApiResponse, LoginResponse> response = await authRepo.login(
      email: emailController.text,
      password: passwordController.text,
    );
    response.fold(
      (l) {
        emit(LoginAuthFailure(l.message.toString()));
      },
      (userModel) {
        // Save user data to shared preferences for EditProfileCubit to use
        EditProfileRepo.instance.saveProfile(
          name: userModel.user.name,
          email: userModel.user.email,
          phone: "01000000000", // Default or fetch real phone if available
          image: "https://cdn-icons-png.flaticon.com/512/149/149071.png",
        );
        emit(LoginAuthSuccess(message: userModel.message.toString()));
      },
    );
  }
}
