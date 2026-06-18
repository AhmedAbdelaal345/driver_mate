import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';

import 'package:driver_mate/core/widget/show_dialoge_widget.dart';
import 'package:driver_mate/feature/home/view/wrapper_page.dart';
import 'package:driver_mate/feature/languge/view/language_page.dart';
import 'package:driver_mate/feature/maintance_history/manager/cubit/maintence_history_cubit.dart';
import 'package:driver_mate/feature/maintance_history/manager/state/maintence_history_state.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_cubit.dart';
import 'package:driver_mate/feature/mycars/manager/vehical_state.dart';
import 'package:driver_mate/feature/notification/view/notification_settings_page.dart';
import 'package:driver_mate/feature/profile/data/model/edit_profile_model.dart';
import 'package:driver_mate/feature/profile/manager/change_password_manager/change_password_cubit.dart';
import 'package:driver_mate/feature/profile/manager/edit_profile_manager/edit_profile_cubit.dart';
import 'package:driver_mate/feature/profile/manager/edit_profile_manager/edit_profile_state.dart';
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
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:driver_mate/feature/saved_item/manager/state/saved_item_state.dart';
import 'package:driver_mate/feature/saved_item/view/saved_item_page.dart';
import 'package:driver_mate/feature/theme/view/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<EditProfileCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
        ),
        actions: [
          IconButton(
            onPressed: () {
              MyNavigation.navigateTo(WrapperPage(initialIndex: 2));
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
        title: Text(
          AppStrings.of(context).profile,
          style: AppStyle.titleForContainer.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.height(context) * 0.02),
              BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  EditProfileModel? profile;

                  if (state is SuccessEditProfile) {
                    profile = state.data;
                  } else if (state is UpdateProfileSuccess) {
                    profile = state.data;
                  }

                  if (profile != null) {
                    return ProfileContainer(
                      name: profile.fullName,
                      email: profile.emailAddress,
                      image: profile.image,
                      onPressed: () {
                        MyNavigation.navigateTo(
                          BlocProvider.value(
                            value: context.read<EditProfileCubit>(),
                            child: const EditProfile(),
                          ),
                        );
                      },
                    );
                  }

                  return ProfileContainer(
                    name: "User",
                    email: "example@email.com",
                    image: AppImagePath.profileIconPath,
                    onPressed: () {
                      MyNavigation.navigateTo(
                        BlocProvider.value(
                          value: context.read<EditProfileCubit>(),
                          child: const EditProfile(),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<VehicalCubit, VehicalState>(
                    builder: (context, state) {
                      if (state is SuccessVehicalState) {
                        return ItemContainer(
                          count: state.data.length,
                          onTap: () {
                            MyNavigation.navigateTo(MyCars());
                          },
                        );
                      } else {
                        return ItemContainer(
                          count: 0,
                          onTap: () {
                            MyNavigation.navigateTo(MyCars());
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(width: SizeConfig.width(context) * 0.03),
                  BlocBuilder<MaintenceHistoryCubit, MaintenceHistoryState>(
                    builder: (context, state) {
                      if (state is MaintenceHistorySuccessState) {
                        return ItemContainer(
                          title: AppStrings.of(context).booking,
                          onTap: () {
                            MyNavigation.navigateTo(MaintenanceHistory());
                          },
                          count: state.items.length,
                        );
                      } else {
                        return ItemContainer(
                          title: AppStrings.of(context).booking,
                          onTap: () {
                            MyNavigation.navigateTo(MaintenanceHistory());
                          },
                          count: 0,
                        );
                      }
                    },
                  ),
                  SizedBox(width: SizeConfig.width(context) * 0.03),

                  BlocBuilder<SavedItemCubit, SavedItemState>(
                    builder: (context, state) {
                      if (state is SavedItemLoaded) {
                        return ItemContainer(
                          title: AppStrings.of(context).saved,
                          count: state.items.length,
                          onTap: () {
                            MyNavigation.navigateTo(SavedItemsPage());
                          },
                        );
                      }
                      return ItemContainer(
                        title: AppStrings.of(context).saved,
                        count: 0,
                        onTap: () {
                          MyNavigation.navigateTo(SavedItemsPage());
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),

              Text(
                AppStrings.of(context).account,
                style: AppStyle.containerSubtitle,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(context),
                child: Column(
                  children: [
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(
                          BlocProvider.value(
                            value: context.read<EditProfileCubit>(),
                            child: const EditProfile(),
                          ),
                        );
                      },
                    ),
                    Divider(color: AppColors.containerGrey),
                    DetailsContainerWidget(
                      title: AppStrings.of(context).myCars,
                      onTap: () {
                        BlocProvider.value(value: context.read<VehicalCubit>());
                        MyNavigation.navigateTo(
                          BlocProvider.value(
                            value: context.read<VehicalCubit>(),
                            child: MyCars(),
                          ),
                        );
                      },
                      subTitle: AppStrings.of(context).manageVehicls,
                      iconpath: AppImagePath.carIconPath,
                    ),
                    Divider(color: AppColors.containerGrey),
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(MaintenanceHistory());
                      },
                      title: AppStrings.of(context).maintenanceHistory,
                      subTitle: AppStrings.of(context).pastbookings,
                      iconpath: AppImagePath.calenderIconPath,
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),

              Text(AppConstants.preference, style: AppStyle.containerSubtitle),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  context,
                ).copyWith(color: Theme.of(context).cardTheme.color),
                child: Column(
                  children: [
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(LanguagePage());
                      },
                      title: AppStrings.of(context).language,
                      subTitle: AppConstants.englishArbic,
                      iconpath: AppImagePath.languageIconPath,
                    ),
                    Divider(color: AppColors.containerGrey),

                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(ThemePage());
                      },
                      title: AppStrings.of(context).theme,
                      subTitle: AppStrings.of(context).lightDark,
                      iconpath: AppImagePath.themeIconPath,
                    ),
                    Divider(color: AppColors.containerGrey),
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(NotificationSettingPage());
                      },
                      title: AppStrings.of(context).notifications,
                      subTitle: AppStrings.of(context).reminder,
                      iconpath: AppImagePath.notificationIconPath,
                    ),
                  ],
                ),
              ),

              SizedBox(height: SizeConfig.height(context) * 0.02),

              Text(
                AppStrings.of(context).security,
                style: AppStyle.containerSubtitle,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(context),
                child: Column(
                  children: [
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(
                          BlocProvider(
                            create: (context) => ChangePasswordCubit(),
                            child: ChangePasswordPage(),
                          ),
                        );
                      },
                      title: AppStrings.of(context).changePassword,
                      subTitle: AppStrings.of(context).changeYourPassword,
                      iconpath: AppImagePath.changePasswordIconPath,
                    ),
                    Divider(color: AppColors.containerGrey),

                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(PrivacyPage());
                      },
                      title: AppStrings.of(context).privacy,
                      subTitle: AppStrings.of(context).appPermissions,
                      iconpath: AppImagePath.privacyIconPath,
                    ),
                    Divider(color: AppColors.containerGrey),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Text(
                AppStrings.of(context).support,
                style: AppStyle.containerSubtitle,
              ),
              SizedBox(height: SizeConfig.height(context) * 0.02),
              Container(
                decoration: BoxDecorationWidget.customBoxDecoration(
                  context,
                ).copyWith(color: Theme.of(context).cardTheme.color),
                child: Column(
                  children: [
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(HelpCenterPage());
                      },
                      title: AppStrings.of(context).helpCenter,
                      subTitle: AppStrings.of(context).reminder,
                      iconpath: AppImagePath.helpCenterIconPath,
                    ),

                    Divider(color: AppColors.containerGrey),
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(ContactSupportPage());
                      },
                      title: AppStrings.of(context).contactSupport,
                      subTitle: AppStrings.of(context).reminder,
                      iconpath: AppImagePath.conatactSupportIconPath,
                    ),

                    Divider(color: AppColors.containerGrey),
                    DetailsContainerWidget(
                      onTap: () {
                        MyNavigation.navigateTo(AboutPage());
                      },
                      title: AppStrings.of(context).about,
                      subTitle: AppStrings.of(context).reminder,
                      iconpath: AppImagePath.aboutIconPath,
                    ),
                    SizedBox(height: SizeConfig.height(context) * 0.02),
                    Container(
                      decoration: BoxDecorationWidget.customBoxDecoration(
                        context,
                      ),
                      child: DetailsContainerWidget(
                        isSvg: false,
                        icon: Icons.logout_outlined,
                        title: AppStrings.of(context).logout,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return ShowDialogWidget(
                                title: AppStrings.of(context).confirmLogout,
                                content: AppStrings.of(
                                  context,
                                ).logoutConfirmation,
                              );
                            },
                          );
                        },
                      ),
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
