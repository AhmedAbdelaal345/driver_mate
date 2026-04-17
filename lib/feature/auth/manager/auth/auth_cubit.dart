import 'package:dartz/dartz.dart';
import 'package:driver_mate/core/local/api_keys.dart';
import 'package:driver_mate/core/network/api_response.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_routes.dart';
import 'package:driver_mate/feature/auth/data/model/auth_model.dart';
import 'package:driver_mate/feature/auth/data/repo/auth_repo.dart';
import 'package:driver_mate/feature/auth/manager/auth/auth_state.dart';
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
        accessToken: "",
      );
      emit(RegisterAuthSuccess(message: success));
    });
  }

  Future<void> logout(BuildContext context) async {
    await EditProfileRepo.instance.clearProfile();

    clearControllers();

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.loginPage,
      (route) => false,
    );
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

 Future<void> onLoginPress() async {
  print("STEP 1: start login");
  emit(LoginAuthLoading());

  try {
    final response = await authRepo.login(
      email: emailController.text,
      password: passwordController.text,
    );

    print("STEP 2: response returned");

    response.fold(
      (failure) {
        print("STEP 3: failure => ${failure.message}");
        emit(LoginAuthFailure(failure.message));
      },
      (success) async {
        print("STEP 4: success");

        await EditProfileRepo.instance.saveProfile(
          name: success.data[ApiKeys.fullname] ?? "Unknown",
          email: success.data[ApiKeys.email],
          phone: "01000000000",
          image: AppImagePath.defaultProfileImagePath,
          accessToken: success.data[ApiKeys.accessToken] ?? "",
        );

        print("STEP 5: saved");

        emit(LoginAuthSuccess(message: success.message));
      },
    );
  } catch (e) {
    print("STEP ERROR: $e");
    emit(LoginAuthFailure(e.toString()));
  }
}}
