import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/helper/image_picker.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
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
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Email is display-only — stored as a plain string, no controller needed
  String _emailDisplay = '';

  @override
  void initState() {
    super.initState();
    final state = context.read<EditProfileCubit>().state;
    if (state is SuccessEditProfile) {
      _fillFields(state.data);
    }
  }

  void _fillFields(dynamic profile) {
    fullNameController.text = profile.fullName;
    phoneController.text = profile.phoneNumber;

    _emailDisplay = profile.emailAddress;
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const LeadingIcon(),
        title: Text(
          AppStrings.of(context).personalInfo,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is SuccessEditProfile) {
            _fillFields(state.data);
            setState(() => _emailDisplay = state.data.emailAddress);
          }
          if (state is UpdateProfileSuccess) {
            AppNotifier.show(
              context,
              state.message,
              type: NotifierType.success,
            );
            MyNavigation.navigateBack();
          }
          if (state is ErrorEditProfile) {
            AppNotifier.show(context, state.error, type: NotifierType.error);
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

                // ── Profile photo picker ──────────────────────────────────
                GestureDetector(
                  onTap: () async {
                    final picked = await ImagePickerHelper.pickImageAsString();
                    if (picked != null && mounted) {
                      context.read<EditProfileCubit>().updateImage(picked);
                    }
                  },
                  child: Column(
                    children: [
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
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.of(context).changeImage,
                        style: AppStyle.mostText.copyWith(
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: SizeConfig.height(context) * 0.02),

                // ── Editable fields ───────────────────────────────────────
                Container(
                  decoration: BoxDecorationWidget.customBoxDecoration(
                    context,
                    borderRadius: AppFontSize.f12,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full name — editable
                      LabelTextWidget(title: AppStrings.of(context).fullName),
                      const SizedBox(height: 6),
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
                      const SizedBox(height: 16),

                      // Phone — editable
                      LabelTextWidget(title: AppStrings.of(context).phone),
                      const SizedBox(height: 6),
                      TextFormFieldWidget(
                        controller: phoneController,
                        hintText: AppStrings.of(context).phone,
                        isPassword: false,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppStrings.of(context).youMust;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email — static display only, cannot be changed
                      LabelTextWidget(
                        title: AppStrings.of(context).emailAddress,
                      ),
                      const SizedBox(height: 6),
                      _StaticEmailField(email: _emailDisplay),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.of(
                          context,
                        ).weWillVerfiction, // e.g. "Email cannot be changed"
                        style: AppStyle.hintStyle,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: SizeConfig.height(context) * 0.015),
                ContainerWidget(),
                SizedBox(height: SizeConfig.height(context) * 0.015),

                // ── Save button ───────────────────────────────────────────
                BlocBuilder<EditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                    if (state is LoadingEditProfile) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.darkBlue,
                        ),
                      );
                    }
                    return PrimaryElevatedButtonWidget(
                      buttonText: AppStrings.of(context).save,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final cubit = context.read<EditProfileCubit>();
                          cubit.changeUser(
                            fullName: fullNameController.text.trim(),
                            phoneNumber: phoneController.text.trim(),
                            image:
                                cubit.selectedImage ??
                                AppImagePath.defaultProfileImagePath,
                          );
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

// ── Static email display widget ───────────────────────────────────────────────
class _StaticEmailField extends StatelessWidget {
  const _StaticEmailField({required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.containerGrey),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              email.isEmpty ? '—' : email,
              style: AppStyle.hintStyle, // muted style signals non-editable
            ),
          ),
          Icon(
            Icons.lock_outline,
            size: 16,
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
    );
  }
}
