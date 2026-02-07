import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/booking/view/maintenance_booking_page.dart';
import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.readTime,
    required this.image,
  });

  final String title;
  final String subtitle;
  final String tag;
  final String readTime;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          // Hero Image with App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.white,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: AppColors.black),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(image, fit: BoxFit.cover),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.width(context) * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and Read Time
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.powderBlueColor,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          tag,
                          style: AppStyle.containerSubtitle.copyWith(
                            fontSize: AppFontSize.f11,
                            color: AppColors.cyanColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        readTime,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f11,
                          color: AppColors.iconGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    title,
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f18,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Article Introduction
                  Text(
                    'Choosing the right car insurance can save you thousands of dollars and provide peace of mind on the road. This comprehensive guide will help you understand your options and make an informed decision.',
                    style: AppStyle.regularSmallText.copyWith(
                      fontSize: AppFontSize.f13,
                      color: AppColors.textGrey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'Whether you\'re buying your first car or switching providers, these tips will ensure you get the best coverage at the right price.',
                    style: AppStyle.regularSmallText.copyWith(
                      fontSize: AppFontSize.f13,
                      color: AppColors.textGrey,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Key Considerations Section
                  Text(
                    'Key Considerations',
                    style: AppStyle.boldSmallText.copyWith(
                      fontSize: AppFontSize.f16,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildNumberedPoint(
                    1,
                    'Coverage Types',
                    'Understand liability, collision, and comprehensive coverage options.',
                  ),
                  _buildNumberedPoint(
                    2,
                    'Deductibles',
                    'Higher deductibles mean lower premiums but more out-of-pocket costs.',
                  ),
                  _buildNumberedPoint(
                    3,
                    'Compare Quotes',
                    'Get quotes from at least 3-5 different providers before deciding.',
                  ),
                  _buildNumberedPoint(
                    4,
                    'Check Discounts',
                    'Ask about safe driver, multi-car, and bundling discounts.',
                  ),
                  _buildNumberedPoint(
                    5,
                    'Review Annually',
                    'Your needs and rates change, so review your policy every year.',
                  ),
                  const SizedBox(height: 24),

                  // Key Takeaway Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cyanColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.cyanColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.cyanColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.lightbulb,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Key Takeaway',
                                style: AppStyle.boldSmallText.copyWith(
                                  fontSize: AppFontSize.f14,
                                  color: AppColors.cyanColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'The best car insurance balances comprehensive coverage with affordable premiums. Always read the fine print and understand what\'s covered before signing up.',
                                style: AppStyle.regularSmallText.copyWith(
                                  fontSize: AppFontSize.f12,
                                  color: AppColors.black,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Save and Share Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Article saved!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: const Icon(Icons.bookmark_outline, size: 18),
                          label: const Text('Save'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.black,
                            side: BorderSide(color: AppColors.grey),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Share options opened'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: const Icon(Icons.share, size: 18),
                          label: const Text('Share'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.black,
                            side: BorderSide(color: AppColors.grey),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Book Maintenance CTA Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const MaintenanceBookingPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.calendar_today, size: 18),
                      label: const Text('Book Maintenance'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkBlue,
                        foregroundColor: AppColors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedPoint(int number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.cyanColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: AppStyle.boldSmallText.copyWith(
                  fontSize: AppFontSize.f12,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyle.boldSmallText.copyWith(
                    fontSize: AppFontSize.f13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppStyle.regularSmallText.copyWith(
                    fontSize: AppFontSize.f12,
                    color: AppColors.textGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
