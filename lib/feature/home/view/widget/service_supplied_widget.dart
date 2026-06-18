import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:flutter/material.dart';

class ServiceSuppliedWidget extends StatelessWidget {
  const ServiceSuppliedWidget({
    super.key,
    this.title,
    this.distance,
    this.rate,
    this.numberOfReviews,
    this.first,
    this.second,
    this.third,
    this.onTap,
  });

  final String? title;
  final String? distance;
  final String? rate;
  final String? numberOfReviews;
  final String? first, second, third;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final items = [first, second, third].where((e) => e != null).toList();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeConfig.width(context) * 0.78,

        margin: const EdgeInsets.only(right: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecorationWidget.customBoxDecoration(
          context,
          borderRadius: 16,
        ).copyWith(
          color: Theme.of(context).cardTheme.color
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            /// 🔹 TITLE
            Text(
              title ?? AppConstants.premiumAutoService,
              style: AppStyle.titleOfContainer,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
      
            const SizedBox(height: 6),
      
            /// 🔹 DISTANCE
            Row(
              children: [
                 Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    distance ?? AppConstants.dist,
                    style: AppStyle.viewAll.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
      
            const SizedBox(height: 8),
      
            /// 🔹 RATING
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 18,
                  color: AppColors.orange,
                ),
                const SizedBox(width: 4),
                Text(rate ?? "4.8",
                    style: AppStyle.titleForContainer.copyWith(fontSize: 14)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    numberOfReviews ?? "(234 reviews)",
                    style: AppStyle.containerSubtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
      
            const SizedBox(height: 10),
      
            /// 🔹 SERVICES TAGS
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: items
                  .map(
                    (text) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.containerGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        text!,
                        style: AppStyle.containerSubtitle,
                      ),
                    ),
                  )
                  .toList(),
            ),
      
            const SizedBox(height: 12),
      
            /// 🔹 BUTTON
            SizedBox(
              height: 40,
              width: double.infinity,
              child: PrimaryElevatedButtonWidget(
                buttonText: AppConstants.bookNow,
                onPressed: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}