import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';

class VoiceBubbleWidget extends StatefulWidget {
  const VoiceBubbleWidget({super.key});
  @override
  State<VoiceBubbleWidget> createState() => _VoiceBubbleWidgetState();

  static double _waveHeight(int index) {
    const heights = [10, 18, 26, 14, 22, 30, 16, 24];
    return heights[index % heights.length].toDouble();
  }
}

class _VoiceBubbleWidgetState extends State<VoiceBubbleWidget> {
  @override
  bool isPressed = false;
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: SizeConfig.width(context) * 0.26, // ✅ عريض زي الصورة
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.cyanColor, Color(0xff047A92)],
          ),
        ),
        child: Row(
          children: [
            // ▶️ Play button
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              child: isPressed
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isPressed = false;
                        });
                      },
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 26,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          isPressed = true;
                        });
                      },
                      icon: const Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
            ),

            const SizedBox(width: 14),

            // 🎵 Extended waveform
            Expanded(
              child: Row(
                children: List.generate(
                  24, // ✅ waveform أطول
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 3,
                    height: VoiceBubbleWidget._waveHeight(index),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // ⏱ Duration
            Text(
              "0:12",
              style: AppStyle.containerSubtitle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
