import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class InputContainerWidget extends StatelessWidget {
  const InputContainerWidget({super.key, this.onTap, this.controller});
  final VoidCallback? onTap;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: const Offset(0, -2),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.containerGrey,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Ask anything about your car...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          _circleButton(Icons.mic, false, context),
          const SizedBox(width: 8),
          _circleButton(Icons.send_rounded, true, context),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, bool isWhite, BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          SizeConfig.width(context) * 0.025,
        ), // Scaled padding
        decoration: BoxDecoration(
          color: isWhite ? AppColors.white : AppColors.cyanColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isWhite ? AppColors.grey : AppColors.white,
          size: SizeConfig.width(context) * 0.06,
        ),
      ),
    );
  }
}
