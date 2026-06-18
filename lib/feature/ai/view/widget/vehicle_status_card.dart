import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VehicleStatusCard extends StatelessWidget {
  const VehicleStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                          decoration: BoxDecorationWidget.customBoxDecoration(context),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                padding: const EdgeInsets.all(8),
                                decoration:
                                    BoxDecorationWidget.customBoxDecoration(context)
                                        .copyWith(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              AppColors.veryDarkBlue,
                                              AppColors.cyanColor,
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),
                                child: SvgPicture.asset(
                                  AppImagePath.doubleArrowIconPath,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppConstants.toyotaCamry,
                                      style: AppStyle.titleOfContainer,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 10,
                                          color: AppColors.green,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          "Status: Good",
                                          style: AppStyle.containerSubtitle
                                              .copyWith(color: AppColors.green),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
  }
}