import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/notification/data/model/notification_model.dart';
import 'package:flutter/material.dart';



class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationCategory _selectedCategory = NotificationCategory.all;

  final List<NotificationModel> _notifications =  [ 
    NotificationModel(
      title: 'Oil change reminder',
      subtitle: 'Due in 500 km. Book a service now.',
      time: '2h',
      isRead: false,
      category: NotificationCategory.maintenance,
      icon: Icons.build_outlined,
    ),
    NotificationModel(
      title: 'Booking confirmed',
      subtitle: 'Your appointment is set for Tue 3:00 PM.',
      time: '5h',
      isRead: false,
      category: NotificationCategory.system,
      icon: Icons.person_outline,
    ),
    NotificationModel(
      title: 'New maintenance tips available',
      subtitle: 'Essential car care for summer driving.',
      time: '1d',
      isRead: true,
      category: NotificationCategory.tips,
      icon: Icons.article_outlined,
    ),
    NotificationModel(
      title: 'Annual inspection due',
      subtitle: 'Schedule your inspection within 7 days.',
      time: '2d',
      isRead: true,
      category: NotificationCategory.maintenance,
      icon: Icons.build_outlined,
    ),
    NotificationModel(
      title: 'EV efficiency milestone',
      subtitle: 'Latest electric vehicles reach new records.',
      time: '3d',
      isRead: true,
      category: NotificationCategory.tips,
      icon: Icons.article_outlined,
    ),
    NotificationModel(
      title: 'Special offer available',
      subtitle: '20% off on brake service this month.',
      time: '1w',
      isRead: true,
      category: NotificationCategory.system,
      icon: Icons.person_outline,
    ),
  ];

  List<NotificationModel> get _filtered {
    if (_selectedCategory == NotificationCategory.all) return _notifications;
    return _notifications
        .where((n) => n.category == _selectedCategory)
        .toList();
  }

  Map<String, List<NotificationModel>> _groupByTime(
    List<NotificationModel> items,
  ) {
    final today = <NotificationModel>[];
    final thisWeek = <NotificationModel>[];
    final earlier = <NotificationModel>[];

    for (final n in items) {
      if (n.time.endsWith('h')) {
        today.add(n);
      } else if (n.time.endsWith('d')) {
        thisWeek.add(n);
      } else {
        earlier.add(n);
      }
    }

    final result = <String, List<NotificationModel>>{};
    if (today.isNotEmpty) result['TODAY'] = today;
    if (thisWeek.isNotEmpty) result['THIS WEEK'] = thisWeek;
    if (earlier.isNotEmpty) result['EARLIER'] = earlier;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByTime(_filtered);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title:  Text(
          AppStrings.of(context).notifications,
          style: AppStyle.appBarTitle,
        ),
        leading: const LeadingIcon(),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {});
            },
            child: Text(
              AppStrings.of(context).markAllRead,
              style: AppStyle.containerSubtitle.copyWith(
                color: AppColors.cyanColor,
                fontSize: AppFontSize.f12,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.height(context) * 0.01),
          _buildFilterTabs(),
          SizedBox(height: SizeConfig.height(context) * 0.01),
          Expanded(
            child: grouped.isEmpty
                ? Center(
                    child: Text(
                      AppStrings.of(context).noNotification,
                      style: AppStyle.containerSubtitle.copyWith(
                        color: AppColors.iconGrey,
                      ),
                    ),
                  )
                : ListView(
                    children: [
                      for (final entry in grouped.entries) ...[
                        _buildSectionHeader(entry.key),
                        for (final notification in entry.value)
                          _buildNotificationTile(notification),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final categories = [
      (NotificationCategory.all, AppStrings.of(context).all),
      (NotificationCategory.maintenance, AppStrings.of(context).maintenance),
      (NotificationCategory.emergency, AppStrings.of(context).emergency),
      (NotificationCategory.tips, AppStrings.of(context).tips),
      (NotificationCategory.system, AppStrings.of(context).system),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context) * 0.04,
      ),
      child: Row(
        children: categories.map((entry) {
          final isSelected = _selectedCategory == entry.$1;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = entry.$1),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.cyanColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.cyanColor
                      : AppColors.containerGrey,
                ),
              ),
              child: Text(
                entry.$2,
                style: AppStyle.containerSubtitle.copyWith(
                  fontSize: AppFontSize.f12,
                  color: isSelected ? AppColors.white : AppColors.textGrey,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.width(context) * 0.05,
        right: SizeConfig.width(context) * 0.05,
        top: SizeConfig.height(context) * 0.018,
        bottom: SizeConfig.height(context) * 0.006,
      ),
      child: Text(
        title,
        style: AppStyle.containerSubtitle.copyWith(
          fontSize: AppFontSize.f11,
          color: AppColors.iconGrey,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNotificationTile(NotificationModel notification) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width(context) * 0.04,
        vertical: 2,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        leading: CircleAvatar(
          backgroundColor: notification.isRead
              ? AppColors.iconGrey.withValues(alpha: 0.15)
              : AppColors.cyanColor,
          child: Icon(
            notification.icon,
            color: notification.isRead ? AppColors.iconGrey : AppColors.white,
            size: 20,
          ),
        ),
        title: Text(
          notification.title,
          style: AppStyle.boldSmallText.copyWith(
            fontSize: AppFontSize.f13,
            color: notification.isRead
                ? AppColors.textGrey
                : AppColors.black,
          ),
        ),
        subtitle: Text(
          notification.subtitle,
          style: AppStyle.containerSubtitle.copyWith(
            fontSize: AppFontSize.f11,
            color: AppColors.iconGrey,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              notification.time,
              style: AppStyle.containerSubtitle.copyWith(
                fontSize: AppFontSize.f11,
                color: AppColors.iconGrey,
              ),
            ),
            if (!notification.isRead) ...[
              const SizedBox(height: 6),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.cyanColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}