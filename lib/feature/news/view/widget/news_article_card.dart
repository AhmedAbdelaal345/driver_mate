import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/news/data/model/news_article_model.dart';
import 'package:flutter/material.dart';

class NewsArticleCard extends StatelessWidget {
  const NewsArticleCard({super.key, required this.article});

  final NewsArticle article;

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'technology':
        return AppColors.cyanColor;
      case 'tips & guides':
        return AppColors.orange;
      case 'maintenance':
        return AppColors.green;
      case 'buying guide':
        return AppColors.purple;
      default:
        return AppColors.cyanColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 80,
              height: 80,
              color: AppColors.grey.withValues(alpha: 0.2),
              child: Icon(
                Icons.directions_car,
                size: 40,
                color: _getCategoryColor(article.category),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Article content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  article.title,
                  style: AppStyle.boldSmallText.copyWith(
                    fontSize: AppFontSize.f15,
                    color: AppColors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                // Description
                Text(
                  article.description,
                  style: AppStyle.regularSmallText.copyWith(
                    fontSize: AppFontSize.f12,
                    color: AppColors.textGrey,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Category and read time
                Row(
                  children: [
                    // Category tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(
                          article.category,
                        ).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        article.category,
                        style: AppStyle.regularSmallText.copyWith(
                          fontSize: AppFontSize.f10,
                          color: _getCategoryColor(article.category),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Read time
                    Text(
                      article.readTime,
                      style: AppStyle.regularSmallText.copyWith(
                        fontSize: AppFontSize.f11,
                        color: AppColors.textGrey,
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
