import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContainerIconWidget extends StatelessWidget {
  const ContainerIconWidget({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  final String icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // ── Card surface + text color both from theme ─────────────────────────
    final cardColor = theme.cardTheme.color ?? theme.colorScheme.surface;
    final textColor = theme.colorScheme.onSurface;
    final iconColor = theme.colorScheme.onSurface;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppFontSize.f12),
        child: Container(
          // ── Fixed: 0.0002 was nearly 0 — use a real height ────────────
          height: SizeConfig.height(context) * 0.11,
          decoration: BoxDecorationWidget.customBoxDecoration(context).copyWith(
            color: cardColor,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context) * 0.03,
            vertical: SizeConfig.height(context) * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: SizeConfig.height(context) * 0.025,
                width: SizeConfig.width(context) * 0.05,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              SizedBox(height: SizeConfig.height(context) * 0.008),
              Flexible(
                child: Text(
                  text,
                  style: AppStyle.coursalSubtitleTextStyle.copyWith(
                    color: textColor, // ← was hardcoded AppColors.black
                    fontSize: AppFontSize.f12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
