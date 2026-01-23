import 'package:carousel_slider/carousel_slider.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/primary_elevated_button_widget.dart';
import 'package:flutter/material.dart';

class CoursalWidget extends StatefulWidget {
  const CoursalWidget({super.key});

  @override
  _CoursalWidgetState createState() => _CoursalWidgetState();
}

class _CoursalWidgetState extends State<CoursalWidget> {
  int _currentIndex = 0;

  final List<String> images = [AppImagePath.loginImagePath];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(
        horizontal: SizeConfig.width(context) * 0.043,
        vertical: SizeConfig.height(context) * 0.015,
      ),
      child: Column(
        children: [
          CarouselSlider(
            items: images.map((img) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: AlignmentGeometry.bottomRight,
                      colors: [AppColors.veryDarkBlue, AppColors.cyanColor],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width(context) * 0.013,
                      vertical: SizeConfig.height(context) * 0.0320,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppConstants.coursalTitle,
                                  style: AppStyle.coursalTitleTextStyle,
                                ),
                                Text(
                                  AppConstants.coursalSubtitle,
                                  style: AppStyle.coursalSubtitleTextStyle,
                                ),
                                SizedBox(height: 10),
                                PrimaryElevatedButtonWidget(
                                  buttonText: AppConstants.startScan,
                                  onPressed: () {},
                                ).copyWith(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeConfig.width(context) * 0.271,
                                    vertical:
                                        SizeConfig.height(context) * 0.0443,
                                  ),
                                  backgroundColor: AppColors.cyanColor,
                                ),
                              ],
                            ),
                            Opacity(
                              opacity: 0.3, // من 0.0 إلى 1.0
                              child: Image.asset(
                                img,
                                fit: BoxFit.scaleDown,
                                width: SizeConfig.width(context) * 0.35,
                                height: SizeConfig.height(context) * 0.20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.asMap().entries.map((entry) {
              return Container(
                width: _currentIndex == entry.key ? 16 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentIndex == entry.key
                      ? Colors.blue
                      : Colors.grey[400],
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
