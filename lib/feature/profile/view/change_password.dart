import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

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
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppConstants.changePassword, style: AppStyle.appBarTitle),
        leading: const LeadingIcon(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context) * 0.05,
            vertical: SizeConfig.height(context) * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.currentPassword,
                      style: AppStyle.labelStyle,
                    ),
                    const SizedBox(height: 8),
                    TextFormFieldWidget(
                      hintText: AppConstants.enterCurrentPassword,
                      isPassword: true,
                      controller: _currentController,
                      validator: (value) => null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppConstants.newPassword,
                      style: AppStyle.labelStyle,
                    ),
                    const SizedBox(height: 8),
                    TextFormFieldWidget(
                      hintText: AppConstants.enterNewPassword,
                      isPassword: true,
                      controller: _newController,
                      validator: (value) => null,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppConstants.confirmNewPassword,
                      style: AppStyle.labelStyle,
                    ),
                    const SizedBox(height: 8),
                    TextFormFieldWidget(
                      hintText: AppConstants.reEnterNewPassword,
                      isPassword: true,
                      controller: _confirmController,
                      validator: (value) => null,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Text(
                AppConstants.passwordRequirements,
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f11,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecorationWidget.customBoxDecoration(
                  borderRadius: AppFontSize.f12,
                ).copyWith(color: AppColors.containerGrey),
                child: Column(
                  children: const [
                    _RequirementRow(text: AppConstants.requirementLength),
                    _RequirementRow(text: AppConstants.requirementUppercase),
                    _RequirementRow(text: AppConstants.requirementLowercase),
                    _RequirementRow(text: AppConstants.requirementNumber),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              ElevatedButton.icon(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.boarderWhiteColor,
                  disabledBackgroundColor: AppColors.boarderWhiteColor,
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.height(context) * 0.018,
                  ),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppFontSize.f12),
                  ),
                ),
                icon: const Icon(
                  Icons.lock_outline,
                  color: AppColors.iconGrey,
                  size: 18,
                ),
                label: Text(
                  AppConstants.saveChanges,
                  style: AppStyle.boldSmallText.copyWith(
                    color: AppColors.iconGrey,
                    fontSize: AppFontSize.f13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  const _RequirementRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.cancel, size: 16, color: AppColors.iconGrey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppStyle.containerSubtitle.copyWith(
                fontSize: AppFontSize.f11,
                color: AppColors.iconGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
