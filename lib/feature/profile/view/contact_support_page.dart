import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/core/widget/textformfield_widget.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/profile/data/repo/contact_us_repo.dart';
import 'package:driver_mate/feature/profile/manager/contact_us_manager/contact_us_cubit.dart';
import 'package:driver_mate/feature/profile/manager/contact_us_manager/contact_us_state.dart';
import 'package:driver_mate/feature/profile/view/widget/contact_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({super.key});

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  final subjectController = TextEditingController();
  final messageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactUsCubit(repo: EmailRepositoryImpl()),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            AppConstants.contactSupport,
            style: AppStyle.appBarTitle,
          ),
          leading: const LeadingIcon(),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width(context) * 0.05,
                vertical: SizeConfig.height(context) * 0.015,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ContactCard(
                    icon: Icons.email_outlined,
                    title: AppConstants.email,
                    subtitle: AppConstants.supportEmail,
                    onTap: () {},
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.015),
                  ContactCard(
                    icon: Icons.phone_outlined,
                    title: AppConstants.callUs,
                    subtitle: AppConstants.supportPhone,
                    onTap: () {},
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.02),
                  Text(
                    AppConstants.sendMessage,
                    style: AppStyle.containerSubtitle.copyWith(
                      color: AppColors.iconGrey,
                      fontSize: AppFontSize.f11,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(AppConstants.subject, style: AppStyle.labelStyle),
                  const SizedBox(height: 8),
                  TextFormFieldWidget(
                    hintText: AppConstants.subjectHint,
                    controller: subjectController,
                    validator: (value) {
                      if (value == null) {
                        return AppConstants.youMust;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 14),
                  Text(AppConstants.message, style: AppStyle.labelStyle),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: messageController,
                    maxLines: 6,
                    cursorColor: AppColors.cyanColor,
                    validator: (value) {
                      if (value == null) {
                        return AppConstants.youMust;
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: AppConstants.messageHint,
                      hintStyle: AppStyle.hintStyle,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppFontSize.f8),
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppFontSize.f8),
                        borderSide: BorderSide(color: AppColors.cyanColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppFontSize.f8),
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      AppConstants.charactersLimit,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f10,
                        color: AppColors.iconGrey,
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.02),
                  BlocConsumer<ContactUsCubit, ContactUsState>(
                    listener: (context, state) {
                      if (state is ContactUsStateFauilor) {
                        AppNotifier.show(
                          context,
                          state.erorr,
                          type: NotifierType.error,
                        );
                      }
                      if (state is ContactUsStateSuccess) {
                        AppNotifier.show(
                          context,
                          state.message,
                          type: NotifierType.success,
                        );
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is ContactUsStateLoading;
                      return ElevatedButton.icon(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<ContactUsCubit>().sendMessage(
                                    subject: subjectController.text,
                                    message: messageController.text,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cyanColor,
                          disabledBackgroundColor: AppColors.boarderWhiteColor,
                          padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.height(context) * 0.018,
                          ),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppFontSize.f12,
                            ),
                          ),
                        ),
                        icon: const Icon(
                          Icons.send_outlined,
                          color: AppColors.iconGrey,
                          size: 18,
                        ),
                        label: Text(
                          AppConstants.sendMessageButton,
                          style: AppStyle.boldSmallText.copyWith(
                            color: AppColors.iconGrey,
                            fontSize: AppFontSize.f13,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: SizeConfig.height(context) * 0.02),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecorationWidget.customBoxDecoration(
                      borderRadius: AppFontSize.f12,
                    ).copyWith(color: AppColors.containerGrey),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.schedule,
                          size: 18,
                          color: AppColors.textGrey,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppConstants.responseTime,
                                style: AppStyle.boldSmallText.copyWith(
                                  fontSize: AppFontSize.f12,
                                  color: AppColors.textGrey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                AppConstants.responseTimeNote,
                                style: AppStyle.regularSmallText.copyWith(
                                  fontSize: AppFontSize.f11,
                                  color: AppColors.iconGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
