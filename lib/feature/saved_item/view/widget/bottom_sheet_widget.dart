import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/feature/saved_item/manager/cubit/saved_item_cubit.dart';
import 'package:driver_mate/feature/saved_item/manager/state/saved_item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showSavedSortSheet(BuildContext context) {
  final cubit = context.read<SavedItemCubit>();

  SavedSortType selected = SavedSortType.mostRecent;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Sort & Filter", style: TextStyle(fontSize: 18)),

                const SizedBox(height: 20),

                _radioTile(
                  context: context,
                  title: "Most Recent",
                  value: SavedSortType.mostRecent,
                  groupValue: selected,
                  onChanged: (val) {
                    setState(() => selected = val!);
                  },
                ),

                _radioTile(
                  context: context,
                  title: "Oldest First",
                  value: SavedSortType.oldestFirst,
                  groupValue: selected,
                  onChanged: (val) {
                    setState(() => selected = val!);
                  },
                ),

                _radioTile(
                  title: "By Type",
                  context: context,
                  value: SavedSortType.byType,
                  groupValue: selected,
                  onChanged: (val) {
                    setState(() => selected = val!);
                  },
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      cubit.changeSort(selected);
                      Navigator.pop(context);
                    },
                    child: const Text("Apply"),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _radioTile({
  required String title,
  required SavedSortType value,
  required SavedSortType groupValue,
  required Function(SavedSortType?) onChanged,
  required BuildContext context,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: RadioListTile<SavedSortType>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: Text(title),
      activeColor: AppColors.cyanColor,
    ),
  );
}
