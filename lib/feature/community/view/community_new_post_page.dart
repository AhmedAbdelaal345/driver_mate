import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:flutter/material.dart';

class CommunityNewPostPage extends StatefulWidget {
  const CommunityNewPostPage({super.key});

  @override
  State<CommunityNewPostPage> createState() => _CommunityNewPostPageState();
}

class _CommunityNewPostPageState extends State<CommunityNewPostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> _postTypes = const [
    AppConstants.question,
    AppConstants.problem,
    AppConstants.tips,
    AppConstants.review,
    AppConstants.marketPlace,
  ];

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

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppConstants.newPost, style: AppStyle.appBarTitle),
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
                AppConstants.postType.toUpperCase(),
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f11,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(_postTypes.length, (index) {
                  final type = _postTypes[index];
                  final isSelected = _selectedType == index;
                  return ChoiceChip(
                    label: Text(type),
                    selected: isSelected,
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.white : AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedColor: AppColors.cyanColor,
                    backgroundColor: AppColors.containerGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                    onSelected: (_) => setState(() => _selectedType = index),
                  );
                }),
              ),
              const SizedBox(height: 18),
              Text(AppConstants.title, style: AppStyle.labelStyle),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null) {
                    return AppConstants.youMust;
                  } else {
                    return null;
                  }
                },
                cursorColor: AppColors.cyanColor,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: AppConstants.titleHint,
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
              Text(AppConstants.description, style: AppStyle.labelStyle),
              const SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value == null) {
                    return AppConstants.youMust;
                  } else {
                    return null;
                  }
                },
                controller: _descriptionController,
                maxLines: 6,
                maxLength: _maxChars,
                cursorColor: AppColors.cyanColor,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: AppConstants.descriptionHint,
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
                    color: AppColors.iconGrey,
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(horizontal, 8, horizontal, 12),
          child: ElevatedButton(
            onPressed: _canPublish ? () {
              
            } : null,
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
              AppConstants.publishPost,
              style: AppStyle.boldSmallText.copyWith(
                color: _canPublish ? AppColors.white : AppColors.iconGrey,
                fontSize: AppFontSize.f13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
