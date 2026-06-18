import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class InputContainerWidget extends StatelessWidget {
  const InputContainerWidget({super.key, this.onTapVoice,this.onTapMessage, this.controller});
  final VoidCallback? onTapVoice;
  final VoidCallback? onTapMessage;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
                color: Theme.of(context).cardColor,
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
          _circleButton(Icons.mic, false, context,onTap: onTapVoice),
          const SizedBox(width: 8),
          _circleButton(Icons.send_rounded, true, context,onTap: onTapMessage),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, bool isWhite, BuildContext context,{void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
          SizeConfig.width(context) * 0.025,
        ), // Scaled padding
        decoration: BoxDecoration(
          color: isWhite ? Theme.of(context).colorScheme.surface : Theme.of(context).colorScheme.secondary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isWhite ? Theme.of(context).colorScheme.onSurface : Theme.of(context).colorScheme.onSecondary,
          size: SizeConfig.width(context) * 0.06,
        ),
      ),
    );
  }
}
