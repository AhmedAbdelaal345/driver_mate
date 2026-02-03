// feature/community/view/widget/community_post_header.dart

import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/view/widget/text_field_widget.dart';
import 'package:flutter/material.dart';

class CommunityPostHeader extends StatelessWidget {
  const CommunityPostHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _key = GlobalKey();
    final TextEditingController controller = TextEditingController();
    return Form(
      key: _key,
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
              children: [
                _buildOption(Icons.image_outlined, "Photo", onTap: () {}),
                const SizedBox(width: 20),
                _buildOption(Icons.mic_none_outlined, "Voice", onTap: () {}),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty &&
                        _key.currentState!.validate()) {
                      _key.currentState!.save();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyanColor, //Color(0xFF1B7F9B),
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
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

  Widget _buildOption(IconData icon, String label, {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.iconGrey),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: AppColors.iconGrey, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
