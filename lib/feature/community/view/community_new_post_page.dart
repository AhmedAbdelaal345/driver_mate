import 'dart:io';

import 'package:driver_mate/core/service/local_notification_service.dart';
import 'package:driver_mate/core/helper/open_gallary.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_cubit.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_state.dart';
import 'package:driver_mate/feature/community/view/widget/add_image_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunityNewPostPage extends StatefulWidget {
  const CommunityNewPostPage({super.key});

  @override
  State<CommunityNewPostPage> createState() => _CommunityNewPostPageState();
}

class _CommunityNewPostPageState extends State<CommunityNewPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? selectedImage;

  int _selectedType = 0;
  static const int _maxChars = 1000;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool get _canPublish {
    return _titleController.text.trim().isNotEmpty &&
        _descriptionController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final horizontal = SizeConfig.width(context) * 0.05;
    // Order matches backend integers: 0=Question, 1=Tips, 2=Review, 3=Marketplace, 4=Problem
    final List<String> postTypes = [
      AppStrings.of(context).question,   // 0
      AppStrings.of(context).tips,       // 1
      AppStrings.of(context).review,     // 2
      AppStrings.of(context).marketPlace,// 3
      AppStrings.of(context).problem,    // 4
    ];

    return BlocConsumer<CommunityPostCubit, CommunityPostState>(
      listener: (context, state) {
        if (state is CommunityPostFailure) {
          AppNotifier.show(context, state.error, type: NotifierType.error);
        }
        if (state is CommunityCreatePostSuccess) {
          AppNotifier.show(context, state.message, type: NotifierType.success);
          LocalNotificationService.basicNotification(
            notificationId: "create_post",
            id: 20,
            title: "Post Published 📝",
            body: "Your post has been successfully published to the community!",
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final isLoading = state is CommunityPostLoading;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              AppStrings.of(context).newPost,
              style: AppStyle.appBarTitle.copyWith(
                color: Theme.of(context).appBarTheme.titleTextStyle?.color,
              ),
            ),
            leading: const LeadingIcon(),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontal,
                vertical: SizeConfig.height(context) * 0.015,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppStrings.of(context).postType.toUpperCase(),
                    style: AppStyle.containerSubtitle.copyWith(
                      color: Theme.of(context).iconTheme.color,
                      fontSize: AppFontSize.f11,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(postTypes.length, (index) {
                      final type = postTypes[index];
                      final isSelected = _selectedType == index;
                      return ChoiceChip(
                        label: Text(type),
                        selected: isSelected,
                        showCheckmark: false,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? AppColors.white
                              : AppColors.boarderWhiteColor,
                          fontWeight: FontWeight.w500,
                        ),
                        selectedColor: AppColors.cyanColor,
                        backgroundColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        onSelected: (_) =>
                            setState(() => _selectedType = index),
                      );
                    }),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    AppStrings.of(context).title,
                    style: AppStyle.labelStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.of(context).youMust;
                      }
                      return null;
                    },
                    cursorColor: AppColors.cyanColor,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: AppStrings.of(context).titleHint,
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
                  const SizedBox(height: 14),
                  Text(
                    AppStrings.of(context).description,
                    style: AppStyle.labelStyle.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppStrings.of(context).youMust;
                      }
                      return null;
                    },
                    controller: _descriptionController,
                    maxLines: 6,
                    maxLength: _maxChars,
                    cursorColor: AppColors.cyanColor,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: AppStrings.of(context).descriptionHint,
                      hintStyle: AppStyle.hintStyle,
                      counterText: '',
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
                      '${_descriptionController.text.length}/$_maxChars characters',
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f10,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () async {
                      final image = await OpenGallery.openGallery();

                      if (image != null) {
                        setState(() {
                          selectedImage = image;
                        });
                      }
                    },
                    child: AddPhotoContainer(
                      isSelected: selectedImage != null ? true : false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(horizontal, 8, horizontal, 12),
              child: ElevatedButton(
                onPressed: _canPublish && !isLoading
                    ? () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          if (_selectedType == 3 && selectedImage == null) {
                            AppNotifier.show(
                              context,
                              "You must add image in marketplace post",
                              type: NotifierType.error,
                            );
                          } else {
                            context.read<CommunityPostCubit>().createPost(
                              type: _selectedType,
                              title: _titleController.text.trim(),
                              description: _descriptionController.text.trim(),
                              image: selectedImage,
                            );
                          }
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _canPublish
                      ? AppColors.darkBlue
                      : AppColors.boarderWhiteColor,
                  disabledBackgroundColor: AppColors.boarderWhiteColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  AppStrings.of(context).publishPost,
                  style: AppStyle.boldSmallText.copyWith(
                    color: _canPublish ? AppColors.white : AppColors.iconGrey,
                    fontSize: AppFontSize.f13,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
