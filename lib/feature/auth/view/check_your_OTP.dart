import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/stack_with_container_widget.dart';
import 'package:driver_mate/feature/auth/manager/forget_password/forget_password_cubit.dart';
import 'package:driver_mate/feature/auth/manager/otp/otp_cubit.dart';
import 'package:driver_mate/feature/auth/manager/otp/otp_state.dart';
import 'package:driver_mate/feature/auth/view/confirm_password_page.dart';
import 'package:driver_mate/feature/auth/view/widget/check_textfield_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckYourOTP extends StatefulWidget {
  const CheckYourOTP({super.key, required this.email});
  final String email;

  @override
  State<CheckYourOTP> createState() => _CheckYourOTPState();
}

class _CheckYourOTPState extends State<CheckYourOTP> {
  final List<TextEditingController> _codeControllers = List.generate(
    5,
    (_) => TextEditingController(),
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _navigationHandled = false;

  String get _currentOtp => _codeControllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (final c in _codeControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: LeadingIcon(),
        title: Text(
          AppStrings.of(context).verifyOTP,
          style: AppStyle.welcomeTextStyle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.035 * SizeConfig.width(context),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.047),
                  StackWithContainerWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    AppStrings.of(context).checkYourEmail,
                    style: AppStyle.labelStyle.copyWith(
                      fontSize: 26,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    AppStrings.of(context).weSentACode,
                    style: AppStyle.hintStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    widget.email,
                    style: AppStyle.labelStyle.copyWith(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    AppStrings.of(context).codeExpiresIn10Minutes,
                    style: AppStyle.hintStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      5,
                      (index) => SizedBox(
                        width: 50,
                        child: CheckTextfieldWidget(
                          controllers: _codeControllers,
                          index: index,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.of(context).pleaseEnterTheCode;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 0.06 * SizeConfig.height(context)),

                  BlocConsumer<OtpCubit, OtpState>(
                    listenWhen: (_, current) =>
                        current is VerifyOtpSuccessState ||
                        current is OtpErrorState,
                    listener: (context, state) {
                      if (state is VerifyOtpSuccessState) {
                        //
                        // ── WHY ORDER MATTERS ─────────────────────────────
                        //
                        // YOUR OLD ORDER (broken):
                        //   1. AppNotifier.show()      ← pushes overlay, triggers rebuild
                        //   2. _navigationHandled = true
                        //   3. if (!mounted) return    ← mounted is FALSE here → exits
                        //   4. MyNavigation.navigateTo ← NEVER RUNS
                        //
                        // AppNotifier.show schedules an overlay entry which
                        // marks the element dirty.  Flutter processes that
                        // dirty element inside the same notifyClients call,
                        // temporarily detaching this State from the tree.
                        // `mounted` reads _element != null — which is null
                        // during detach — so it returns false and the guard
                        // exits before navigation ever fires.
                        //
                        // CORRECT ORDER:
                        //   1. Guard first   (no side effects yet)
                        //   2. Snapshot data (context valid now, may not be later)
                        //   3. Notification  (overlay side effect, safe after guard)
                        //   4. Deferred nav  (addPostFrameCallback, frame is stable)

                        // 1. Guard — must come first, before any side effect.
                        if (_navigationHandled) return;
                        _navigationHandled = true;

                        // 2. Snapshot cubit + otp NOW.
                        //    context.read inside addPostFrameCallback is unsafe
                        //    because the BlocProvider may no longer be in scope
                        //    after a rebuild.  Capture the reference
                        //    synchronously while the listener context is valid.
                        final otpCubit = context.read<OtpCubit>();
                        final otp = _currentOtp;

                        // 3. Show notification (safe now — guard already set).
                        AppNotifier.show(
                          context,
                          state.message,
                          type: NotifierType.success,
                        );

                        // 4. Defer navigation to next frame.
                        //    WHY addPostFrameCallback:
                        //    The listener runs during Flutter's element
                        //    notification pass (notifyClients → rebuild).
                        //    Calling Get.to() at this moment asks GetX to push
                        //    a route while the element tree is still mid-update,
                        //    which corrupts Focus scope ancestry → crash.
                        //    Waiting one frame ensures all dirty elements are
                        //    flushed and the tree is stable before GetX touches
                        //    the navigator.
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          // mounted check here is safe: we only skip if the
                          // user physically navigated away between the listener
                          // call and this callback (e.g. pressed Back very fast).
                          if (!mounted) return;

                          MyNavigation.navigateTo(
                            // WHY BlocProvider.value:
                            // Get.to pushes the route outside the current
                            // widget tree, so ConfirmPasswordPage and
                            // SetNewPasswordPage lose access to OtpCubit.
                            // BlocProvider.value re-exposes the SAME instance
                            // (no new cubit created, state preserved).
                            BlocProvider.value(
                              value: otpCubit,
                              child: ConfirmPasswordPage(
                                email: widget.email,
                                otp: otp,
                              ),
                            ),
                          );
                        });
                      } else if (state is OtpErrorState) {
                        // Reset so the user can retry after fixing their OTP.
                        _navigationHandled = false;
                        AppNotifier.show(
                          context,
                          state.error,
                          type: NotifierType.error,
                        );
                      }
                    },

                    builder: (context, state) {
                      if (state is VerifyOtpLoadingState) {
                        return CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.secondary,
                        );
                      }

                      return PrimaryElevatedButtonWidget(
                        formKey: _formKey,
                        buttonText: AppStrings.of(context).verifyCode,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<OtpCubit>().verifyOTP(
                              email: widget.email,
                              otp: _currentOtp,
                            );
                          }
                        },
                      );
                    },
                  ),

                  SizedBox(height: 0.032 * SizeConfig.height(context)),

                  Row(
                    children: [
                      Text(
                        AppStrings.of(context).dontHaveAccount,
                        style: AppStyle.hintStyle.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<ForgetPasswordCubit>().forgetPassword(
                            widget.email,
                          );
                        },
                        child: Text(
                          AppStrings.of(context).resendCode,
                          style: AppStyle.signUpTextStyle.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
