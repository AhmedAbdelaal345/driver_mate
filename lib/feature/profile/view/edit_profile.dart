import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/helper/image_picker.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/stack_with_container_widget.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/mycars/view/widget/container_widget.dart';
import 'package:driver_mate/feature/profile/manager/edit_profile_manager/edit_profile_cubit.dart';
import 'package:driver_mate/feature/profile/manager/edit_profile_manager/edit_profile_state.dart';
import 'package:driver_mate/feature/profile/view/widget/label_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // ✅ Pre-fill controllers if data is already loaded — no double fetch
    final state = context.read<EditProfileCubit>().state;
    if (state is SuccessEditProfile) {
      _fillControllers(state.data);
    }
    // No getUserData() call here — cubit constructor already fetched it
  }

  void _fillControllers(dynamic profile) {
    fullNameController.text = profile.fullName;
    emailController.text = profile.emailAddress;
    phoneController.text = profile.phoneNumber;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: Text(AppConstants.personalInfo, style: AppStyle.appBarTitle),
        centerTitle: true,
      ),
      body: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          // ✅ Fill controllers when data loads (handles the async case)
          if (state is SuccessEditProfile) {
            _fillControllers(state.data);
          }

          if (state is UpdateProfileSuccess) {
            AppNotifier.show(
              context,
              state.message,
              type: NotifierType.success,
            );
            MyNavigation.navigateBack(); // single navigateBack — only here
          }

          if (state is ErrorEditProfile) {
            AppNotifier.show(
              context,
              state.error,
              type: NotifierType.error,
            );
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    final picked = await ImagePickerHelper.pickImageAsString();
                    if (picked != null && mounted) {
                      context.read<EditProfileCubit>().updateImage(picked);
                    }
                  },
                  child: Column(
                    children: [
                      // ✅ EditProfileImageChanged state now handled here
                      BlocBuilder<EditProfileCubit, EditProfileState>(
                        builder: (context, state) {
                          final cubit = context.read<EditProfileCubit>();
                          String imageToShow = AppImagePath.profileIconPath;

                          if (cubit.selectedImage != null) {
                            imageToShow = cubit.selectedImage!;
                          } else if (state is SuccessEditProfile) {
                            imageToShow = state.data.image;
                          } else if (state is UpdateProfileSuccess) {
                            imageToShow = state.data.image;
                          }

                          return StackWithContainerWidget(
                            iconPath: imageToShow,
                            icon: Icons.camera_alt_outlined,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(AppConstants.changeImage, style: AppStyle.mostText),
                    ],
                  ),
                ),
                SizedBox(height: 0.02 * SizeConfig.height(context)),
                Container(
                  decoration: BoxDecorationWidget.customBoxDecoration(),
                  height: SizeConfig.height(context) * 0.4,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelTextWidget(title: AppConstants.fullName),
                      TextFormFieldWidget(
                        controller: fullNameController,
                        hintText: AppConstants.enterYourName,
                        isPassword: false,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppConstants.youMust;
                          }
                          return null;
                        },
                      ),
                      LabelTextWidget(title: AppConstants.phone),
                      TextFormFieldWidget(
                        controller: phoneController,
                        hintText: AppConstants.phone,
                        isPassword: false,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppConstants.youMust;
                          }
                          return null;
                        },
                      ),
                      LabelTextWidget(title: AppConstants.emailAddress),
                      TextFormFieldWidget(
                        controller: emailController,
                        hintText: AppConstants.emailAddress,
                        isPassword: false,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppConstants.youMust;
                          }
                          return null;
                        },
                      ),
                      Text(AppConstants.weWillVerfiction, style: AppStyle.hintStyle),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.015),
                ContainerWidget(),
                SizedBox(height: SizeConfig.height(context) * 0.015),
                BlocBuilder<EditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                    if (state is LoadingEditProfile) {
                      return const Center(
                        child: CircularProgressIndicator(color: AppColors.darkBlue),
                      );
                    }
                    return PrimaryElevatedButtonWidget(
                      buttonText: AppConstants.save,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final cubit = context.read<EditProfileCubit>();
                          cubit.changeUser(
                            fullName: fullNameController.text.trim(),
                            emailAddress: emailController.text.trim(),
                            phoneNumber: phoneController.text.trim(),
                            image: cubit.selectedImage
                                ?? AppImagePath.defaultProfileImagePath,
                          );
                          // ✅ No navigateBack() here — listener handles it
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}