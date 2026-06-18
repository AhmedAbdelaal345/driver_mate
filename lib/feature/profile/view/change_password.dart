import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/profile/manager/change_password_manager/change_password_cubit.dart';
import 'package:driver_mate/feature/profile/manager/change_password_manager/change_password_state.dart';
import 'package:driver_mate/feature/profile/view/widget/requirement_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.of(context).changePassword,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        leading: const LeadingIcon(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context) * 0.05,
            vertical: SizeConfig.height(context) * 0.015,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecorationWidget.customBoxDecoration(
                    context,
                    borderRadius: AppFontSize.f12,
                  ).copyWith(color: Theme.of(context).scaffoldBackgroundColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.of(context).currentPassword,
                        style: AppStyle.labelStyle,
                      ),
                      const SizedBox(height: 8),
                      TextFormFieldWidget(
                        hintText: AppStrings.of(context).enterCurrentPassword,
                        isPassword: true,
                        controller: _currentController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.of(
                              context,
                            ).currentPasswordRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.of(context).newPassword,
                        style: AppStyle.labelStyle,
                      ),
                      const SizedBox(height: 8),
                      TextFormFieldWidget(
                        hintText: AppStrings.of(context).enterNewPassword,
                        isPassword: true,
                        controller: _newController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.of(context).newPasswordRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.of(context).confirmNewPassword,
                        style: AppStyle.labelStyle,
                      ),
                      const SizedBox(height: 8),
                      TextFormFieldWidget(
                        hintText: AppStrings.of(context).reEnterNewPassword,
                        isPassword: true,
                        controller: _confirmController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.of(
                              context,
                            ).confirmNewPasswordRequired;
                          }
                          if (value != _newController.text) {
                            return AppStrings.of(context).passwordsDoNotMatch;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.02),
                Text(
                  AppStrings.of(context).passwordRequirements,
                  style: AppStyle.containerSubtitle.copyWith(
                    color: AppColors.iconGrey,
                    fontSize: AppFontSize.f11,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecorationWidget.customBoxDecoration(
                    context,
                    borderRadius: AppFontSize.f12,
                  ).copyWith(color: Theme.of(context).cardTheme.color),
                  child: Column(
                    children: [
                      RequirementRow(
                        text: AppStrings.of(context).requirementLength,
                      ),
                      RequirementRow(
                        text: AppStrings.of(context).requirementUppercase,
                      ),
                      RequirementRow(
                        text: AppStrings.of(context).requirementLowercase,
                      ),
                      RequirementRow(
                        text: AppStrings.of(context).requirementNumber,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.02),
                BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                  listener: (context, state) {
                    if (state is ChangePasswordErrorState) {
                      AppNotifier.show(
                        context,
                        type: NotifierType.error,
                        state.errorMessage,
                      );
                    }
                    if (state is ChangePasswordSuccessState) {
                      AppNotifier.show(
                        context,
                        type: NotifierType.success,
                        "Password changed successfully",
                      );
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is ChangePasswordLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(  context).colorScheme.primary,
                        ),
                      );
                    }
                    return ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ChangePasswordCubit>().changePassword(
                            _currentController.text,
                            _newController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        disabledBackgroundColor: Theme.of(context).colorScheme.primary,
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.height(context) * 0.018,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppFontSize.f12),
                        ),
                      ),
                      icon:  Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).iconTheme.color,
                        size: 18,
                      ),
                      label: Text(
                        AppStrings.of(context).saveChanges,
                        style: AppStyle.boldSmallText.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                          fontSize: AppFontSize.f13,
                        ),
                      ),
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
