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
import 'package:driver_mate/feature/profile/view/widget/label_text_widget.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final GlobalKey<FormState> key = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIcon(),
        title: Text(AppConstants.personalInfo, style: AppStyle.appBarTitle),
        centerTitle: true,
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // here we will add the fuctionality for take image
                  },
                  child: Column(
                    children: [
                      StackWithContainerWidget(
                        iconPath: AppImagePath.profileIconPath,
                        icon: Icons.camera_alt_outlined,
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
                  padding: EdgeInsets.all(16),
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
                          if (value == null) {
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
                          if (value == null) {
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
                          if (value == null) {
                            return AppConstants.youMust;
                          }
                          return null;
                        },
                      ),

                      Text(
                        AppConstants.weWillVerfiction,
                        style: AppStyle.hintStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.015),
                ContainerWidget(),
                SizedBox(height: SizeConfig.height(context) * 0.015),
                PrimaryElevatedButtonWidget(
                  buttonText: AppConstants.save,
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      //here will make the functionality
                    }
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
