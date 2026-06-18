import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    this.readMore,
    this.height,
    this.onTap,
    this.width,
    this.isAppear,
  });

  final String title;
  final String subtitle;
  final String imagePath;
  final double? width;
  final double? height;
  final bool? isAppear;
  final String? readMore;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConfig.height(context) * 0.015),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecorationWidget.customBoxDecoration(context).copyWith(
          color: Theme.of(context).cardTheme.color, // ← was hardcoded AppColors.white
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🖼 IMAGE
            Container(
              height: height ?? 55,
              width: width ?? 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 14),

            /// 📝 TEXT AREA
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyle.coursalSubtitleTextStyle.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: AppFontSize.f15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// SUBTITLE + ICON
                  Row(
                    children: [
                      if (isAppear == true || isAppear == null) ...[
                         Icon(
                          Icons.access_time,
                          size: 16,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 6),
                      ],
                      Flexible(
                        child: Text(
                          subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyle.coursalSubtitleTextStyle.copyWith(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: AppFontSize.f12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (isAppear == true || isAppear == null) ...[
                    const SizedBox(height: 10),

                    /// READ MORE
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(readMore ?? "", style: AppStyle.viewAll),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_right_alt,
                          size: 18,
                          color: AppColors.cyanColor,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
