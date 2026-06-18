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

class CommunityPostHeader extends StatefulWidget {
  const CommunityPostHeader({super.key, required this.postType});

  final String postType;

  @override
  State<CommunityPostHeader> createState() => _CommunityPostHeaderState();
}

class _CommunityPostHeaderState extends State<CommunityPostHeader> {
  final TextEditingController _controller = TextEditingController();

  // _pickedImage is purely local UI state — it has nothing to do with the
  // cubit, so setState is the correct tool here.
  File? _pickedImage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => _pickedImage = File(picked.path));
  }

  // WHY no async/await here?
  // createPost already handles its own async flow inside the cubit and emits
  // CommunityPostLoading → CommunityPostSuccess/Failure.  The widget only
  // needs to *fire* the action; the BlocConsumer listener below reacts to the
  // result. Awaiting here would block the widget unnecessarily and duplicate
  // loading tracking.
  void _submitPost(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    context.read<CommunityPostCubit>().createPost(
      type: widget.postType,
      title: text,
      description: text,
      image: _pickedImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    // WHY BlocConsumer instead of BlocBuilder?
    // - listener: handles one-off side effects that must not re-run on every
    //   rebuild (clearing the form, showing a SnackBar).
    // - builder:  derives the loading flag from the single source of truth
    //   (the cubit state) so the button and spinner are always in sync.
    //
    // Before this fix the widget owned a local _isPosting bool.  If the cubit
    // emitted CommunityPostFailure the local flag stayed true forever because
    // the catch block ran in a try/catch that was no longer awaited — the
    // spinner would spin endlessly.
    return BlocConsumer<CommunityPostCubit, CommunityPostState>(
      // Only listen when a terminal state is reached so we don't fire the
      // side-effect on intermediate Loading emits.
      listenWhen: (_, current) =>
          current is CommunityPostSuccess || current is CommunityPostFailure,
      listener: (context, state) {
        if (state is CommunityPostSuccess) {
          // Clear local form state on confirmed success from the cubit.
          _controller.clear();
          setState(() => _pickedImage = null);

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
      // WHY buildWhen?
      // The cubit also emits CommunityPostSuccess immediately followed by
      // CommunityPostLoaded. Without buildWhen the builder fires twice in a
      // single frame (Success → Loaded). We only need a rebuild when the
      // loading flag actually changes, so we compare the runtimeType.
      buildWhen: (previous, current) =>
          previous.runtimeType != current.runtimeType,
      builder: (context, state) {
        // Derive loading purely from cubit — no local bool needed.
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
                      style: TextStyle(color: Theme.of(context).colorScheme.surface, fontSize: 14),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: TextFieldWidget(controller: _controller)),
                ],
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

              // ── Action row ─────────────────────────────────────
              Row(
                children: [
                  _buildOption(
                    Icons.image_outlined,
                    'Photo',
                    // Disable picking while a post is in flight.
                    onTap: isPosting ? null : _pickImage,
                  ),
                  const SizedBox(width: 20),
                  _buildOption(
                    Icons.mic_none_outlined,
                    'Voice',
                    onTap: isPosting ? null : () {},
                  ),
                  const Spacer(),
                  isPosting
                      ?  SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      : ElevatedButton(
                          // Pass context explicitly so _submitPost can call
                          // context.read safely even when called from a
                          // nested callback.
                          onPressed: () => _submitPost(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            foregroundColor: Theme.of(context).colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
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

  Widget _buildOption(IconData icon, String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).iconTheme.color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: Theme.of(context).iconTheme.color, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
  