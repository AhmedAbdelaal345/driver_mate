import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/cartips/view/widget/header_image.dart';
import 'package:driver_mate/feature/cartips/view/widget/tip_Item.dart';
import 'package:driver_mate/feature/home/view/widget/container_title.dart';
import 'package:flutter/material.dart';

class CarTipsPage extends StatelessWidget {
  const CarTipsPage({
    super.key,
    required this.assetName,
    this.labelText,
    this.hintText,
  });

  final String assetName;
  final String? hintText;
  final String? labelText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(AppConstants.carTips, style: AppStyle.appBarTitle),
        leading: const LeadingIcon(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark_border_outlined,
              color: AppColors.iconGrey,
            ),
          ),
          SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share, color: AppColors.iconGrey),
          ),
          SizedBox(width: 12),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER IMAGE
              HeaderImage(
                assetName: assetName,
                hintText: hintText,
                labelText: labelText,
              ),

              /// RELATED TIPS TITLE
              ContainerTitle(
                isAppear: true,
                onTap: () {},
                title: AppConstants.relatedTips,
                subTitle: AppConstants.seeAll,
              ),

              const SizedBox(height: 12),

              /// RELATED LIST
              TipItem(
                title: "Understanding Dashboard Warning Lights",
                tag: "Safety",
                time: "4 min read",
              ),
              const SizedBox(height: 12),

              TipItem(
                title: "How to Change Your Oil at Home",
                tag: "DIY Tips",
                time: "6 min read",
              ),
              const SizedBox(height: 12),

              TipItem(
                title: "Tire Maintenance Complete Guide",
                tag: "Maintenance",
                time: "5 min read",
              ),

              const SizedBox(height: 20),

              /// SAVE + REMINDER
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                          BorderSide(color: AppColors.cyanColor, width: 1),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: AppColors.cyanColor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark_border,
                        color: AppColors.cyanColor,
                      ),
                      label: const Text(
                        AppConstants.save,
                        style: AppStyle.viewAll,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: AppColors.iconGrey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none,
                        color: AppColors.iconGrey,
                      ),
                      label: const Text(
                        AppConstants.setReminder,
                        style: TextStyle(color: AppColors.iconGrey),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// VIEW MORE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xff1E3A5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    AppConstants.viewMoreTips,
                    style: AppStyle.coursalTitleTextStyle,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
