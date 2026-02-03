import 'package:carousel_slider/carousel_slider.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:flutter/material.dart';

class CoursalWidget extends StatefulWidget {
  const CoursalWidget({super.key, this.isAppear, this.onPressed});
  final bool? isAppear;
  final VoidCallback? onPressed;
  @override
  _CoursalWidgetState createState() => _CoursalWidgetState();
}

class _CoursalWidgetState extends State<CoursalWidget> {
  int _currentIndex = 0;

  static final List<String> images = [
    AppImagePath.loginImagePath,
    AppImagePath.bmwCarImagePath,
    AppImagePath.applePath,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: images.map((img) {
            return Padding(
              // This creates the gap between the items
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.veryDarkBlue, AppColors.cyanColor],
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: SizeConfig.width(context) * 0.04,
                            vertical: SizeConfig.height(context) * 0.025,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              widget.isAppear == true
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppFontSize.f10,
                                      ),
                                      decoration:
                                          BoxDecorationWidget.customBoxDecoration()
                                              .copyWith(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      AppFontSize.f18,
                                                    ),
                                                color: AppColors.grey
                                                    .withValues(alpha: 0.5),
                                                border: Border.all(
                                                  color: AppColors.grey
                                                      .withValues(alpha: 0.5),
                                                ),
                                              ),
                                      child: Text(
                                        AppConstants.due,
                                        style: AppStyle.buttonTextStyle
                                            .copyWith(
                                              fontSize: AppFontSize.f12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 5),
                              Text(
                                AppConstants.coursalTitle,
                                style: AppStyle.coursalTitleTextStyle,
                              ),
                              Text(
                                AppConstants.coursalSubtitle,
                                style: AppStyle.coursalSubtitleTextStyle,
                              ),
                              const SizedBox(height: 10),
                              FittedBox(
                                child: SizedBox(
                                  width: SizeConfig.width(context) * 0.2,
                                  height: SizeConfig.height(context) * 0.06,
                                  child:
                                      PrimaryElevatedButtonWidget(
                                        buttonText: AppConstants.startScan,
                                        onPressed: widget.onPressed,
                                      ).copyWith(
                                        backgroundColor: AppColors.cyanColor,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.width(context) * 0.03),
                      Opacity(
                        opacity: 0.3,
                        child: Image.asset(
                          img,
                          width: SizeConfig.width(context) * 0.32,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: SizeConfig.height(context) * 0.27,
            autoPlay: true,
            // Key settings to remove the "floating" margins but keep items separate
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        const SizedBox(height: 8),
        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((entry) {
            final bool isActive = _currentIndex == entry.key;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isActive ? 18 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isActive ? Colors.blue : Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
