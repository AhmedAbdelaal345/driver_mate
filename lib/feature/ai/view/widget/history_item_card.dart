import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/feature/ai/data/model/get_diagnosis_history_model.dart';
import 'package:driver_mate/feature/ai/manager/cubit/audio_play_back_cubit.dart';
import 'package:driver_mate/feature/ai/manager/state/audio_play_back_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Single history card — icon, message, severity badge, date, play button.
/// Kept as its own widget so it's reusable and the list stays readable.
class HistoryItemCard extends StatelessWidget {
  const HistoryItemCard({
    super.key,
    required this.item,
    required this.severityColor,
  });

  final GetDiagnosisHistoryModel item;
  final Color severityColor;

  // Manual formatting — avoids pulling intl into production code
  // since it's currently a dev_dependency only.
  String _formatDateTime(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    final minute = dt.minute.toString().padLeft(2, '0');
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year} • $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSeverity = item.result.severity.isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecorationWidget.customBoxDecoration(
        context,
        borderRadius: AppFontSize.f12,
      ).copyWith(color: theme.colorScheme.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Analysis icon ────────────────────────────────────────
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.cyanColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.graphic_eq_rounded,
                  color: AppColors.cyanColor,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),

              // ── Message + date ───────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.result.message.isEmpty
                          ? 'No result available'
                          : item.result.message,
                      style: AppStyle.boldSmallText.copyWith(
                        fontSize: AppFontSize.f13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDateTime(item.createdAt),
                      style: AppStyle.containerSubtitle.copyWith(
                        fontSize: AppFontSize.f10,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // ── Severity badge ───────────────────────────────────────
              if (hasSeverity)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: severityColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    item.result.severity,
                    style: AppStyle.containerSubtitle.copyWith(
                      fontSize: AppFontSize.f10,
                      color: severityColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 10),
          Divider(
            height: 1,
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 4),

          // ── Play audio control ────────────────────────────────────────
          _PlayAudioButton(itemId: item.id, audioUrl: item.audioPath),

          // TODO: add an expandable section here for future details —
          // e.g. confidence breakdown chart, waveform preview, or
          // a "view full AI explanation" expansion tile.
        ],
      ),
    );
  }
}

// ── Play/pause control — reads global AudioPlaybackCubit ──────────────────
class _PlayAudioButton extends StatelessWidget {
  const _PlayAudioButton({required this.itemId, required this.audioUrl});

  final String itemId;
  final String audioUrl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlaybackCubit, AudioPlaybackState>(
      builder: (context, state) {
        // Only show non-idle visuals if THIS item is the active one
        final isThisItem = state.currentId == itemId;
        final status = isThisItem ? state.status : AudioPlaybackStatus.idle;

        late IconData icon;
        late String label;
        switch (status) {
          case AudioPlaybackStatus.loading:
            icon = Icons.hourglass_empty;
            label = 'Loading...';
            break;
          case AudioPlaybackStatus.playing:
            icon = Icons.pause_circle_outline;
            label = 'Pause';
            break;
          case AudioPlaybackStatus.paused:
            icon = Icons.play_circle_outline;
            label = 'Resume';
            break;
          case AudioPlaybackStatus.error:
            icon = Icons.error_outline;
            label = 'Retry';
            break;
          case AudioPlaybackStatus.idle:
            icon = Icons.play_circle_outline;
            label = 'Play Audio';
            break;
        }

        final color = status == AudioPlaybackStatus.error
            ? AppColors.red
            : AppColors.cyanColor;

        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            final cubit = context.read<AudioPlaybackCubit>();
            if (status == AudioPlaybackStatus.playing) {
              cubit.pauseAudio();
            } else {
              cubit.playAudio(itemId, audioUrl);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                status == AudioPlaybackStatus.loading
                    ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: color,
                        ),
                      )
                    : Icon(icon, size: 18, color: color),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f11,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
