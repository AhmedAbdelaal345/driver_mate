import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_image_path.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/news/view/article_detail_page.dart';
import 'package:flutter/material.dart';

class CarNewsPage extends StatelessWidget {
  const CarNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final news = [
      _NewsItem(
        image: AppImagePath.firstImagePath,
        title: AppConstants.newsTitle1,
        subtitle: AppConstants.newsSub1,
        tag: AppConstants.newsTagTech,
        readTime: AppConstants.read5,
      ),
      _NewsItem(
        image: AppImagePath.secondImagePath,
        title: AppConstants.newsTitle2,
        subtitle: AppConstants.newsSub2,
        tag: AppConstants.newsTagTips,
        readTime: AppConstants.read7,
      ),
      _NewsItem(
        image: AppImagePath.thirdImagePath,
        title: AppConstants.newsTitle3,
        subtitle: AppConstants.newsSub3,
        tag: AppConstants.newsTagMaintenance,
        readTime: AppConstants.read6,
      ),
      _NewsItem(
        image: AppImagePath.loginImagePath,
        title: AppConstants.newsTitle4,
        subtitle: AppConstants.newsSub4,
        tag: AppConstants.newsTagBuying,
        readTime: AppConstants.read8,
      ),
      _NewsItem(
        image: AppImagePath.carImagePath,
        title: AppConstants.newsTitle5,
        subtitle: AppConstants.newsSub5,
        tag: AppConstants.newsTagTips,
        readTime: AppConstants.read4,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(AppConstants.carNews, style: AppStyle.appBarTitle),
        leading: const LeadingIcon(),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width(context) * 0.05,
          vertical: SizeConfig.height(context) * 0.015,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailPage(
                  title: news[index].title,
                  subtitle: news[index].subtitle,
                  tag: news[index].tag,
                  readTime: news[index].readTime,
                  image: news[index].image,
                ),
              ),
            );
          },
          child: _NewsCard(item: news[index]),
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: news.length,
      ),
    );
  }
}

class _NewsItem {
  const _NewsItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.readTime,
  });

  final String image;
  final String title;
  final String subtitle;
  final String tag;
  final String readTime;
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.item});

  final _NewsItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecorationWidget.customBoxDecoration(
        borderRadius: AppFontSize.f12,
      ).copyWith(color: AppColors.white),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppFontSize.f10),
            child: Image.asset(
              item.image,
              width: 70,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppStyle.boldSmallText.copyWith(
                    fontSize: AppFontSize.f12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f10,
                    color: AppColors.iconGrey,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.powderBlueColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.tag,
                        style: AppStyle.containerSubtitle.copyWith(
                          fontSize: AppFontSize.f10,
                          color: AppColors.cyanColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.readTime,
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f10,
                        color: AppColors.iconGrey,
                      ),
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
