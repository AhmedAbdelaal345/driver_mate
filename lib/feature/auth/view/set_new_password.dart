import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
// import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_regexp.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/container_icon.dart';
import 'package:driver_mate/feature/auth/manager/otp/otp_cubit.dart';
import 'package:driver_mate/feature/auth/manager/otp/otp_state.dart';
import 'package:driver_mate/feature/auth/view/login_page.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:driver_mate/feature/profile/view/widget/requirement_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetNewPasswordPage extends StatefulWidget {
  const SetNewPasswordPage({super.key, required this.email, required this.otp});

  final String email;
  final String otp;

  @override
  State<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  late final TextEditingController _passwordController;
  late final TextEditingController _passwordConfirmController;
  late final GlobalKey<FormState> _formKey;

  // WHY: Same navigation guard as CheckYourOTP. The listener fires once per
  // state emission, but hot-reloads or rapid emits can cause it to fire
  // multiple times. A guard prevents showing the bottom sheet twice.
  bool _successHandled = false;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  // WHY accept BuildContext as a parameter:
  // The BlocConsumer listener gives us the Scaffold's context, which has
  // access to the Navigator and all providers above SetNewPasswordPage.
  // _showSuccessBottomSheet is called from that listener context — passing it
  // in avoids accidentally capturing a stale or builder-scoped context later.
  void _showSuccessBottomSheet(BuildContext pageContext) {
    showModalBottomSheet(
      // WHY useRootNavigator: true:
      // GetX registers its own navigator at the root. Using the root navigator
      // ensures the bottom sheet is pushed above the GetX page stack, not
      // inside the current route's local navigator (if any). Without this,
      // the bottom sheet's own context is a child of the current route and
      // gets disposed with it if navigation happens simultaneously.
      useRootNavigator: true,
      context: pageContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // isDismissible: false forces the user through the button, preventing
      // a half-navigated state where the sheet is swiped away without going
      // to LoginPage.
      isDismissible: false,
      enableDrag: false,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.035 * SizeConfig.width(pageContext),
            vertical: 0.1 * SizeConfig.height(pageContext),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppImagePath.correctMarkPath),
              SizedBox(height: 0.02 * SizeConfig.height(pageContext)),
              Text(
                AppStrings.of(pageContext).success,
                style: AppStyle.labelStyle.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 0.02 * SizeConfig.height(pageContext)),
              Text(
                AppStrings.of(pageContext).passwordChangedMessage,
                style: AppStyle.hintStyle.copyWith(
                  color: Theme.of(context).iconTheme.color,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0.02 * SizeConfig.height(pageContext)),
              PrimaryElevatedButtonWidget(
                buttonText: AppStrings.of(pageContext).continu,
                onPressed: () {
                  // WHY: First close the bottom sheet, THEN navigate.
                  // Calling MyNavigation.navigateTo while the bottom sheet's
                  // route is still mounted asks GetX to push a new route on
                  // top of both the page AND the modal — resulting in two
                  // extra entries on the stack and a broken Back behaviour.
                  //
                  // Navigator.pop(sheetContext) removes the modal first.
                  // addPostFrameCallback then navigates in the next clean
                  // frame when the modal's elements are fully unmounted.
                  Navigator.of(sheetContext).pop();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    MyNavigation.navigateTo(LoginPage());
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: LeadingIcon(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.04 * SizeConfig.width(context),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 0.044 * SizeConfig.height(context)),
                ContainerForIcon(iconPath: AppImagePath.lockIconPath),
                SizedBox(height: 0.044 * SizeConfig.height(context)),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.of(context).setNewPassword,
                    style: AppStyle.labelStyle.copyWith(
                      fontSize: AppFontSize.f20,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                Text(
                  AppStrings.of(context).setNewPasswordHintText,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.of(context).password,
                    style: AppStyle.labelStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                TextFormFieldWidget(
                  hintText: AppStrings.of(context).enterYourPassword,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.of(context).pleaseEnterYourPassword;
                    } else if (!RegExp(
                      AppRegExp.passwordValidationPattern,
                    ).hasMatch(value)) {
                      return AppStrings.of(context).pleaseEnterValidPassword;
                    }
                    return null;
                  },
                  controller: _passwordController,
                ),
                SizedBox(height: 0.047 * MediaQuery.of(context).size.height),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.of(context).confirmPassword,
                    style: AppStyle.labelStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                SizedBox(height: 0.01 * MediaQuery.of(context).size.height),
                TextFormFieldWidget(
                  hintText: AppStrings.of(context).reEnterYourPassword,
                  isPassword: true,
                  controller: _passwordConfirmController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.of(context).pleaseEnterYourPassword;
                    } else if (value != _passwordController.text) {
                      return AppStrings.of(context).doesntMatch;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 0.03 * MediaQuery.of(context).size.height),
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
                SizedBox(height: 0.03 * MediaQuery.of(context).size.height),

                BlocConsumer<OtpCubit, OtpState>(
                  listenWhen: (_, current) =>
                      current is ResetPasswordSuccessState ||
                      current is OtpErrorState,
                  listener: (context, state) {
                    if (state is ResetPasswordSuccessState) {
                      AppNotifier.show(
                        context,
                        state.message,
                        type: NotifierType.success,
                      );

                      if (_successHandled) return;
                      _successHandled = true;

                      // WHY addPostFrameCallback:
                      // Same reason as CheckYourOTP — showModalBottomSheet
                      // navigates the GetX route stack. Calling it directly
                      // inside the listener (which runs during
                      // notifyClients / element rebuild) causes the Focus
                      // ancestor assertion. Deferring waits until the frame
                      // is fully committed.
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!mounted) return;
                        _showSuccessBottomSheet(context);
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    } else if (state is OtpErrorState) {
                      _successHandled = false;
                      AppNotifier.show(
                        context,
                        state.error,
                        type: NotifierType.error,
                      );
                    }
                  },
                  buildWhen: (previous, current) =>
                      previous.runtimeType != current.runtimeType,
                  builder: (context, state) {
                    if (state is ResetPasswordLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      );
                    }

                    return PrimaryElevatedButtonWidget(
                      buttonText: AppStrings.of(context).updatePassword,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<OtpCubit>().postOTP(
                            widget.email,
                            widget.otp,
                            _passwordController.text,
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
