// feature/community/view/widget/market_place_post_header.dart

import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/view/widget/text_field_widget.dart';
import 'package:flutter/material.dart';

class MarketplacePostHeader extends StatelessWidget {
  const MarketplacePostHeader({
    super.key,
    required this.controller,
    this.onPressedForCategory,
    this.onPressedForImage,
    this.onPressedForLocation,
  });
  final TextEditingController controller;
  final VoidCallback? onPressedForImage;
  final VoidCallback? onPressedForCategory;
  final VoidCallback? onPressedForLocation;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> key = GlobalKey();
    return Form(
      key: key,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecorationWidget.customBoxDecoration(),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF1B7F9B),
                  child: Text(
                    "YO",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: TextFieldWidget(controller: controller)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPostOption(
                  Icons.image_outlined,
                  "Photo",
                  onPressedForImage,
                ),
                _buildPostOption(
                  Icons.category_outlined,
                  "Category",
                  onPressedForCategory,
                ),
                _buildPostOption(
                  Icons.location_on_outlined,
                  "Location",
                  onPressedForLocation,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty ||
                        key.currentState!.validate()) {}
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B7F9B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text(AppConstants.post),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostOption(
    IconData icon,
    String label,
    VoidCallback? onPressed,
  ) {
    return Row(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, size: 20, color: AppColors.iconGrey),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: AppColors.midGrey, fontSize: 13)),
      ],
    );
  }
}
