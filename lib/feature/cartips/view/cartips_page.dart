import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:driver_mate/feature/cartips/view/widget/header_image.dart';
import 'package:driver_mate/feature/cartips/view/widget/tip_item.dart';
import 'package:driver_mate/feature/home/view/widget/container_title.dart';
import 'package:driver_mate/feature/saved_item/data/model/saved_item_model.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:driver_mate/feature/saved_item/manager/state/saved_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarTipsPage extends StatefulWidget {
  const CarTipsPage({
    super.key,
    required this.imagePath,
    this.labelText,
    this.hintText,
  });

  final String imagePath;
  final String? hintText;
  final String? labelText;

  @override
  State<CarTipsPage> createState() => _CarTipsPageState();
}

class _CarTipsPageState extends State<CarTipsPage> {
  bool isBookmarked = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final cubit = context.read<SavedItemCubit>();
    final state = cubit.state;

    if (state is SavedItemLoaded) {
      isBookmarked = state.items.any((e) => e.title == widget.labelText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          AppStrings.of(context).carTips,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        leading: const LeadingIcon(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isBookmarked = !isBookmarked;
                if (isBookmarked == true) {
                  context.read<SavedItemCubit>().addItem(
                    SavedItemModel(
                      title: widget.labelText ?? "",
                      subtitle: widget.hintText ?? "",
                      image: widget.imagePath,
                      type: SavedType.article,
                      readTime: "5 min read",
                    ),
                  );
                  AppNotifier.show(
                    context,
                    "The Item Saved Successfully",
                    type: NotifierType.success,
                  );
                } else {
                  context.read<SavedItemCubit>().removeItem(
                    SavedItemModel(
                      title: widget.labelText ?? "",
                      subtitle: widget.hintText ?? "",
                      image: widget.imagePath,
                      type: SavedType.article,
                      readTime: "5 min read",
                    ),
                  );
                  AppNotifier.show(
                    context,
                    "The Item Removed Successfully",
                    type: NotifierType.error,
                  );
                }
              });
            },
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border_outlined,
              color: isBookmarked
                  ? AppColors.cyanColor
                  : Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share, color: Theme.of(context).iconTheme.color),
          ),
          SizedBox(width: 12),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER IMAGE
              HeaderImage(
                imagePath: widget.imagePath,
                hintText: widget.hintText,
                labelText: widget.labelText,
              ),

              /// RELATED TIPS TITLE
              ContainerTitle(
                isAppear: true,
                onTap: () {},
                title: AppStrings.of(context).relatedTips,
                subTitle: AppStrings.of(context).seeAll,
              ),

              const SizedBox(height: 12),

              /// RELATED LIST
              TipItem(
                title: "Understanding Dashboard Warning Lights",
                tag: "Safety",
                time: "4 min read",
              ),
              const SizedBox(height: 12),

              TipItem(
                title: "How to Change Your Oil at Home",
                tag: "DIY Tips",
                time: "6 min read",
              ),
              const SizedBox(height: 12),

              TipItem(
                title: "Tire Maintenance Complete Guide",
                tag: "Maintenance",
                time: "5 min read",
              ),

              const SizedBox(height: 20),

              /// SAVE + REMINDER
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                        side: WidgetStatePropertyAll(
                          BorderSide(color: AppColors.cyanColor, width: 1),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: AppColors.cyanColor,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          isBookmarked = !isBookmarked;
                        });
                      },
                      icon: Icon(
                        isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border_outlined,
                        color: isBookmarked
                            ? AppColors.cyanColor
                            : AppColors.iconGrey,
                      ),
                      label: Text(
                        AppStrings.of(context).save,
                        style: AppStyle.viewAll,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: AppColors.iconGrey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_none,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      label: Text(
                        AppStrings.of(context).setReminder,
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// VIEW MORE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xff1E3A5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    AppStrings.of(context).viewMoreTips,
                    style: AppStyle.coursalTitleTextStyle.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
