import 'package:carousel_slider/carousel_slider.dart';
import 'package:driver_mate/core/helper/my_navigation.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/ai/view/ai_voice_diagnosis_page.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:driver_mate/feature/emergency/view/emergency_assistance_page.dart';
import 'package:driver_mate/feature/maintance_booking/view/book_maintenance_page.dart';
import 'package:flutter/material.dart';

class CoursalWidget extends StatefulWidget {
  const CoursalWidget({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  _CoursalWidgetState createState() => _CoursalWidgetState();
}

class _CoursalWidgetState extends State<CoursalWidget> {
  int _currentIndex = 0;

  static final List<_CarouselItem> _items = [
    _CarouselItem(
      badge: 'Fast response',
      title: 'Emergency Assist',
      subtitle: 'Send your location instantly to get help',
      buttonText: 'Get Help',
      image: AppImagePath.carImagePath,
      onPressed: () {
        MyNavigation.navigateTo(EmergencyAssistancePage());
      },
    ),
    _CarouselItem(
      badge: 'Due in 500 km',
      title: 'Maintenance Reminder',
      subtitle: 'Oil change due soon based on your mileage',
      buttonText: 'Book Now',
      image: AppImagePath.loginImagePath,
      onPressed: () {
        MyNavigation.navigateTo(BookMaintenancePage());
      },
    ),
    _CarouselItem(
      badge: null,
      title: AppConstants.coursalTitle,
      subtitle: AppConstants.coursalSubtitle,
      buttonText: AppConstants.startScan,
      image: AppImagePath.camryCarImagePath,
      onPressed: () {
        MyNavigation.navigateTo(AiVoiceDiagnosisPage());
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cardHeight = SizeConfig.height(context) * 0.23;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          items: _items
              .map((item) => _buildSlide(context, item, cardHeight))
              .toList(),
          options: CarouselOptions(
            height: cardHeight,
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        Positioned(
          bottom: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _items.asMap().entries.map((entry) {
              final bool isActive = _currentIndex == entry.key;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: isActive ? 22 : 8,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.white
                      : AppColors.white.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(999),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSlide(BuildContext context, _CarouselItem item, double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.veryDarkBlue, AppColors.cyanColor],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.12),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width(context) * 0.05,
                  vertical: SizeConfig.height(context) * 0.012,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (item.badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          item.badge!,
                          style: AppStyle.buttonTextStyle.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      item.title,
                      style: AppStyle.coursalTitleTextStyle.copyWith(
                        fontSize: 17,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item.subtitle,
                      style: AppStyle.coursalSubtitleTextStyle.copyWith(
                        fontSize: 11,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 30,
                      child: PrimaryElevatedButtonWidget(
                        onPressed: widget.onPressed,

                        buttonText: item.buttonText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    item.image,
                    fit: BoxFit.cover,
                    alignment: Alignment.centerRight,
                    filterQuality: FilterQuality.high,
                  ),
                  Container(color: AppColors.black.withValues(alpha: 0.25)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarouselItem {
  const _CarouselItem({
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.image,
    this.badge,
    this.onPressed,
  });

  final String title;
  final String subtitle;
  final String buttonText;
  final String image;
  final String? badge;
  final VoidCallback? onPressed;
}
