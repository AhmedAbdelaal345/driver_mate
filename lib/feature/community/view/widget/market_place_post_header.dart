import 'dart:io';

import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_cubit.dart';
import 'package:driver_mate/feature/community/manager/community_post_manager/community_post_state.dart';
import 'package:driver_mate/feature/community/view/widget/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class MarketplacePostHeader extends StatefulWidget {
  const MarketplacePostHeader({super.key});

  @override
  State<MarketplacePostHeader> createState() => _MarketplacePostHeaderState();
}

class _MarketplacePostHeaderState extends State<MarketplacePostHeader> {
  final TextEditingController _controller = TextEditingController();

  // All three fields below are local UI state — not cubit concerns.
  File? _pickedImage;
  String _selectedCategory = '';
  String _selectedLocation = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _pickedImage = File(picked.path));
  }

  void _pickCategory() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _CategorySheet(
        onSelected: (cat) {
          setState(() => _selectedCategory = cat);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _pickLocation() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _LocationSheet(
        onSelected: (loc) {
          setState(() => _selectedLocation = loc);
          Navigator.pop(context);
        },
      ),
    );
  }

  // Same reasoning as CommunityPostHeader — fire and forget; the BlocConsumer
  // listener handles success/failure reactions.
  void _submitPost(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final description =
        '${_selectedCategory.isNotEmpty ? '[$_selectedCategory] ' : ''}$text'
        '${_selectedLocation.isNotEmpty ? ' — $_selectedLocation' : ''}';

    context.read<CommunityPostCubit>().createPost(
      type: AppConstants.marketPlace,
      title: text,
      description: description,
      image: _pickedImage,
    );
  }

  void _resetLocalState() {
    _controller.clear();
    setState(() {
      _pickedImage = null;
      _selectedCategory = '';
      _selectedLocation = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommunityPostCubit, CommunityPostState>(
      listenWhen: (_, current) =>
          current is CommunityPostSuccess || current is CommunityPostFailure,
      listener: (context, state) {
        if (state is CommunityPostSuccess) {
          _resetLocalState();
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green.shade700,
                behavior: SnackBarBehavior.floating,
              ),
            );
        } else if (state is CommunityPostFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red.shade700,
                behavior: SnackBarBehavior.floating,
              ),
            );
        }
      },
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        final isPosting = state is CommunityPostLoading;

        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecorationWidget.customBoxDecoration(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Input row ──────────────────────────────────────
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      'YO',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: TextFieldWidget(controller: _controller)),
                ],
              ),

              // ── Selected badges ────────────────────────────────
              if (_selectedCategory.isNotEmpty || _selectedLocation.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      if (_selectedCategory.isNotEmpty)
                        _Badge(
                          label: _selectedCategory,
                          icon: Icons.category_outlined,
                          onRemove: () =>
                              setState(() => _selectedCategory = ''),
                        ),
                      if (_selectedLocation.isNotEmpty)
                        _Badge(
                          label: _selectedLocation,
                          icon: Icons.location_on_outlined,
                          onRemove: () =>
                              setState(() => _selectedLocation = ''),
                        ),
                    ],
                  ),
                ),

              // ── Image preview ──────────────────────────────────
              if (_pickedImage != null) ...[
                const SizedBox(height: 10),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _pickedImage!,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => setState(() => _pickedImage = null),
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 14),

              // ── Bottom action row ──────────────────────────────
              Row(
                children: [
                  _buildPostOption(
                    Icons.image_outlined,
                    'Photo',
                    isPosting ? null : _pickImage,
                  ),
                  const SizedBox(width: 8),
                  _buildPostOption(
                    Icons.category_outlined,
                    'Category',
                    isPosting ? null : _pickCategory,
                  ),
                  const SizedBox(width: 8),
                  _buildPostOption(
                    Icons.location_on_outlined,
                    'Location',
                    isPosting ? null : _pickLocation,
                  ),
                  const Spacer(),
                  isPosting
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () => _submitPost(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.secondary,
                            foregroundColor: Theme.of(
                              context,
                            ).colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          child: const Text(AppConstants.post),
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPostOption(
    IconData icon,
    String label,
    VoidCallback? onPressed,
  ) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 22, color: Theme.of(context).iconTheme.color),
        ),
      ),
    );
  }
}

// ── Category bottom sheet ──────────────────────────────────────────────────────
class _CategorySheet extends StatelessWidget {
  final ValueChanged<String> onSelected;

  const _CategorySheet({required this.onSelected});

  static const _categories = [
    'Engine Parts',
    'Tires & Wheels',
    'Electrical',
    'Body & Exterior',
    'Interior',
    'Tools',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Category',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _categories
                .map(
                  (cat) => GestureDetector(
                    onTap: () => onSelected(cat),
                    child: Chip(
                      label: Text(
                        cat,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.secondary.withValues(alpha: 0.1),
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ── Location bottom sheet ──────────────────────────────────────────────────────
class _LocationSheet extends StatelessWidget {
  final ValueChanged<String> onSelected;

  const _LocationSheet({required this.onSelected});

  static const _locations = [
    'Cairo',
    'Giza',
    'Alexandria',
    'New Cairo',
    'Nasr City',
    '6th of October',
    'Zagazig',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Select Location',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _locations
                .map(
                  (loc) => GestureDetector(
                    onTap: () => onSelected(loc),
                    child: Chip(
                      label: Text(loc),
                      backgroundColor: Theme.of(context).colorScheme.secondary.withValues(
                        alpha: 0.1,
                      ),
                      labelStyle:  TextStyle(color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ── Small badge shown after selection ─────────────────────────────────────────
class _Badge extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onRemove;

  const _Badge({
    required this.label,
    required this.icon,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 4),
          Text(
            label,
            style:  TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child:  Icon(
              Icons.close,
              size: 14,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
