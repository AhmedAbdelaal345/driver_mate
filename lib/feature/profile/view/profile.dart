import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/languge/view/language_page.dart';
import 'package:driver_mate/feature/profile/view/about_page.dart';
import 'package:driver_mate/feature/profile/view/change_password.dart';
import 'package:driver_mate/feature/profile/view/contact_support_page.dart';
import 'package:driver_mate/feature/profile/view/edit_profile.dart';
import 'package:driver_mate/feature/maintance_history/view/maintance_history.dart';
import 'package:driver_mate/feature/mycars/view/my_cars.dart';
import 'package:driver_mate/feature/profile/view/help_center_page.dart';
import 'package:driver_mate/feature/profile/view/privacy_page.dart';
import 'package:driver_mate/feature/profile/view/widget/details_container_widget.dart';
import 'package:driver_mate/feature/profile/view/widget/item_container.dart';
import 'package:driver_mate/feature/profile/view/widget/profile_container.dart';
import 'package:driver_mate/feature/theme/view/theme_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings, color: AppColors.black),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
        ],
        title: const Text(
          AppConstants.profile,
          style: AppStyle.titleForContainer,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.height(context) * 0.02),
              ProfileContainer(
                onPressed: () {
                  MyNavigation.navigateTo(EditProfile());
                },
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ItemContainer(),
                  SizedBox(width: SizeConfig.width(context) * 0.03),
                  ItemContainer(title: AppConstants.booking),
                  SizedBox(width: SizeConfig.width(context) * 0.03),

                  ItemContainer(title: AppConstants.saved),
                ],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),

              Text(AppConstants.account, style: AppStyle.containerSubtitle),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(),
                child: Column(
                  children: [
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(EditProfile());
                      },
                    ),
                    Divider(color: AppColors.containerGrey),
                    DetailsContainerWidget(
                      title: AppConstants.myCars,
                      onTap: () {
                        MyNavigation.navigateTo(MyCars());
                      },
                      subTitle: AppConstants.manageVehicls,
                      iconpath: AppImagePath.carIconPath,
                    ),
                    Divider(color: AppColors.containerGrey),
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(MaintenanceHistory());
                      },
                      title: AppConstants.maintenanceHistory,
                      subTitle: AppConstants.pastbookings,
                      iconpath: AppImagePath.calenderIconPath,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),

              Text(AppConstants.preference, style: AppStyle.containerSubtitle),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(),
                child: Column(
                  children: [
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(LanguagePage());
                      },
                      title: AppConstants.language,
                      subTitle: AppConstants.englishArbic,
                      iconpath: AppImagePath.languageIconPath,
                    ),
                    Divider(color: AppColors.containerGrey),

                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(ThemePage());
                      },
                      title: AppConstants.theme,
                      subTitle: AppConstants.lightDark,
                      iconpath: AppImagePath.themeIconPath,
                    ),
                    Divider(color: AppColors.containerGrey),
                    DetailsContainerWidget(
                      onTap: () {},
                      title: AppConstants.notifications,
                      subTitle: AppConstants.reminder,
                      iconpath: AppImagePath.notificationIconPath,
                    ),
                  ],
                ),
              ),

              SizedBox(height: SizeConfig.height(context) * 0.02),

              Text(AppConstants.settings, style: AppStyle.containerSubtitle),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(),
                child: Column(
                  children: [
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(ChangePasswordPage());
                      },
                      title: AppConstants.changePassword,
                      subTitle: AppConstants.changeYourPassword,
                      iconpath: AppImagePath.changePasswordIconPath,
                    ),
                    Divider(color: AppColors.containerGrey),

                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(PrivacyPage());
                      },
                      title: AppConstants.privacy,
                      subTitle: AppConstants.permession,
                      iconpath: AppImagePath.privacyIconPath,
                    ),
                    Divider(color: AppColors.containerGrey),
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(HelpCenterPage());
                      },
                      title: AppConstants.helpCenter,
                      subTitle: AppConstants.reminder,
                      iconpath: AppImagePath.helpCenterIconPath,
                    ),

                    Divider(color: AppColors.containerGrey),
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(ContactSupportPage());
                      },
                      title: AppConstants.contactSupport,
                      subTitle: AppConstants.reminder,
                      iconpath: AppImagePath.conatactSupportIconPath,
                    ),

                    Divider(color: AppColors.containerGrey),
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(AboutPage());
                      },
                      title: AppConstants.about,
                      subTitle: AppConstants.reminder,
                      iconpath: AppImagePath.aboutIconPath,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
