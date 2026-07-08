import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/cartips/data/model/car_tip_list_model.dart';
import 'package:flutter/material.dart';

class TipCard extends StatefulWidget {
  final CarTipListModel tip;
  final void Function()? onPressed;
  final IconData icon;
  const TipCard({
    super.key,
    required this.tip,
    required this.onPressed,
    required this.icon,
  });

  @override
  State<TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<TipCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecorationWidget.customBoxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.tip.title, style: AppStyle.titleOfContainer),
              IconButton(
                onPressed: widget.onPressed,
                icon: Icon(widget.icon, color: Theme.of(context).primaryColor),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            widget.tip.content,
            style: AppStyle.containerSubtitle.copyWith(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: Theme.of(context).iconTheme.color,
              ),
              SizedBox(width: 6),
              Text(
                "${widget.tip.createdAt.minute} min read",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
              Spacer(),
              if (widget.tip.createdAt.difference(DateTime.now()).inDays > 7)
                Text(
                  "Updated recently",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
