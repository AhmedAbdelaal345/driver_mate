import 'dart:async';
import 'dart:io';

import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
// import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_strings.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/ai/data/model/ai_diagnosis_response_model.dart';
import 'package:driver_mate/feature/ai/manager/cubit/ai_diagnosis_response_cubit.dart';
import 'package:driver_mate/feature/ai/manager/cubit/get_diagnosis_history_cubit.dart';
import 'package:driver_mate/feature/ai/manager/state/ai_diagnosis_response_state.dart';
import 'package:driver_mate/feature/ai/manager/state/get_diagnosis_history_state.dart';
import 'package:driver_mate/feature/auth/view/widget/leading_icon.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AiVoiceDiagnosisPage extends StatefulWidget {
  const AiVoiceDiagnosisPage({super.key});

  @override
  State<AiVoiceDiagnosisPage> createState() => _AiVoiceDiagnosisPageState();
}

class _AiVoiceDiagnosisPageState extends State<AiVoiceDiagnosisPage> {
  // ── Constants ─────────────────────────────────────────────────────────────
  static const int _maxSeconds = 30;
  static const int _minSeconds = 5;

  // ── Dependencies ──────────────────────────────────────────────────────────
  final AudioRecorder _recorder = AudioRecorder();
  final ScrollController _scrollController = ScrollController();

  // ── State ─────────────────────────────────────────────────────────────────
  Timer? _timer;
  int _elapsed = 0;
  bool _isRecording = false;

  // ─────────────────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    context.read<GetDiagnosisHistoryCubit>().fetchHistory();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // ── Pagination ────────────────────────────────────────────────────────────
  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      context.read<GetDiagnosisHistoryCubit>().loadMore();
    }
  }

  // ── Recording ─────────────────────────────────────────────────────────────

  Future<void> _startRecording(BuildContext context) async {
    // 1. Permission check
    if (!await _recorder.hasPermission()) {
      _showSnackBar(AppStrings.of(context).micPermissionDenied);
      return;
    }

    // 2. Build a real file path
    final dir = await getTemporaryDirectory();
    final path =
        '${dir.path}/ai_voice_${DateTime.now().millisecondsSinceEpoch}.wav';

    // 3. Start recording to a real file (WAV)
    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.wav,
        sampleRate: 44100,
        bitRate: 128000,
      ),
      path: path,
    );

    if (!mounted) return;
    setState(() {
      _isRecording = true;
      _elapsed = 0;
    });

    // 4. Tick timer — auto-stop at max duration
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _elapsed++);
      if (_elapsed >= _maxSeconds) _stopRecording();
    });
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();

    // stop() returns the actual path of the written file
    final path = await _recorder.stop();

    if (!mounted) return;
    setState(() => _isRecording = false);

    // 5-second minimum validation
    if (_elapsed < _minSeconds) {
      _showSnackBar(AppStrings.of(context).recordingTooShort);
      return;
    }

    if (path == null || !File(path).existsSync()) {
      _showSnackBar(AppStrings.of(context).noRecordingFound);
      return;
    }

    // Auto-upload
    await _uploadFile(path);
  }

  // ── Upload ────────────────────────────────────────────────────────────────

  /// Upload any file path (recorded or picked from device)
  Future<void> _uploadFile(String path) async {
    if (!mounted) return;
    await context.read<AiDiagnosisCubit>().sendAudio(file: File(path));

    // Refresh history on success
    if (!mounted) return;
    if (context.read<AiDiagnosisCubit>().state is AiDiagnosisSuccess) {
      context.read<GetDiagnosisHistoryCubit>().fetchHistory();
    }
  }

  /// Let the user pick an audio file from device storage
  Future<void> _pickAndUploadAudio() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );
      if (result == null || result.files.isEmpty) return;

      final picked = result.files.single;

      if (picked.path != null) {
        await _uploadFile(picked.path!);
        return;
      }

      // Fallback: bytes path (web / some platforms)
      if (picked.bytes == null) {
        _showSnackBar(AppStrings.of(context).pickAudioFailed);
        return;
      }

      final dir = await getTemporaryDirectory();
      final tempPath = '${dir.path}/${picked.name}';
      await File(tempPath).writeAsBytes(picked.bytes!, flush: true);
      await _uploadFile(tempPath);
    } catch (_) {
      _showSnackBar(AppStrings.of(context).pickAudioFailed);
    }
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  void _showSnackBar(String message) {
    if (!mounted) return;
    AppNotifier.show(context, message, type: NotifierType.error);
  }

  Color _severityColor(String? severity) {
    switch (severity?.toLowerCase()) {
      case 'high':
        return AppColors.red;
      case 'medium':
        return AppColors.orange;
      case 'low':
        return AppColors.green;
      default:
        return AppColors.iconGrey;
    }
  }

  // ── Build ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final timeLabel = '${_elapsed.toString().padLeft(2, '0')}s';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.of(context).aiVoiceDiagnosis,
          style: AppStyle.appBarTitle.copyWith(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color,
          ),
        ),
        leading: const LeadingIcon(),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width(context) * 0.05,
            vertical: SizeConfig.height(context) * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Hint banner ───────────────────────────────────────────────
              _HintBanner(),

              SizedBox(height: SizeConfig.height(context) * 0.03),

              // ── Mic button ────────────────────────────────────────────────
              Center(
                child: GestureDetector(
                  onTap: _isRecording
                      ? _stopRecording
                      : () => _startRecording(context),
                  child: _MicButton(isRecording: _isRecording),
                ),
              ),

              const SizedBox(height: 10),

              Center(
                child: Text(
                  _isRecording
                      ? AppStrings.of(context).recordStop
                      : AppStrings.of(context).tapToStart,
                  style: AppStyle.containerSubtitle.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: AppFontSize.f12,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              Center(
                child: Text(
                  _isRecording
                      ? timeLabel
                      : AppStrings.of(context).max30Seconds,
                  style: AppStyle.containerSubtitle.copyWith(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: AppFontSize.f10,
                  ),
                ),
              ),

              SizedBox(height: SizeConfig.height(context) * 0.02),

              // ── Upload from device button ─────────────────────────────────
              BlocBuilder<AiDiagnosisCubit, AiDiagnosisState>(
                builder: (context, state) {
                  final isUploading = state is AiDiagnosisLoading;
                  return _UploadFromDeviceButton(
                    isUploading: isUploading,
                    onTap: isUploading ? null : _pickAndUploadAudio,
                  );
                },
              ),

              SizedBox(height: SizeConfig.height(context) * 0.02),

              // ── Diagnosis result / error ───────────────────────────────────
              BlocBuilder<AiDiagnosisCubit, AiDiagnosisState>(
                builder: (context, state) {
                  if (state is AiDiagnosisError) {
                    return _DiagnosisErrorCard(message: state.message);
                  }
                  if (state is AiDiagnosisSuccess) {
                    return _DiagnosisResultCard(result: state.result);
                  }
                  return const SizedBox.shrink();
                },
              ),

              // ── Recent scans header ───────────────────────────────────────
              Text(
                AppStrings.of(context).recentScans,
                style: AppStyle.containerSubtitle.copyWith(
                  color: AppColors.iconGrey,
                  fontSize: AppFontSize.f11,
                ),
              ),

              const SizedBox(height: 8),

              // ── History list ──────────────────────────────────────────────
              BlocBuilder<GetDiagnosisHistoryCubit, GetDiagnosisHistoryState>(
                builder: (context, state) {
                  if (state is GetDiagnosisHistoryLoading) {
                    return const _CenteredLoader();
                  }

                  if (state is GetDiagnosisHistoryError) {
                    return _HistoryErrorWidget(
                      message: state.message,
                      onRetry: () => context
                          .read<GetDiagnosisHistoryCubit>()
                          .fetchHistory(),
                    );
                  }

                  if (state is GetDiagnosisHistorySuccess) {
                    if (state.items.isEmpty) {
                      return _EmptyHistory();
                    }

                    return Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.items.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (_, index) {
                            final item = state.items[index];
                            return _ScanTile(
                              time: item.createdAt.toString(),
                              title: item.result.message,
                              level: item.result.severity,
                              color: _severityColor('high'),
                            );
                          },
                        ),

                        // Load-more spinner
                        if (state.isLoadingMore)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: _CenteredLoader(strokeWidth: 2),
                          ),

                        // End of list
                        if (!state.hasMore && state.items.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Center(
                              child: Text(
                                AppStrings.of(context).noMoreScans,
                                style: AppStyle.containerSubtitle.copyWith(
                                  color: AppColors.iconGrey,
                                  fontSize: AppFontSize.f11,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Private widgets  (stateless, focused, reusable within this feature)
// ═════════════════════════════════════════════════════════════════════════════

class _HintBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration:
          BoxDecorationWidget.customBoxDecoration(
            context,
            borderRadius: AppFontSize.f12,
          ).copyWith(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.veryDarkBlue, AppColors.cyanColor],
            ),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.of(context).recordCarSound,
            style: AppStyle.boldSmallText.copyWith(
              color: AppColors.white,
              fontSize: AppFontSize.f13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppStrings.of(context).recordHint,
            style: AppStyle.containerSubtitle.copyWith(
              color: AppColors.white.withValues(alpha: 0.9),
              fontSize: AppFontSize.f11,
            ),
          ),
        ],
      ),
    );
  }
}

class _MicButton extends StatelessWidget {
  const _MicButton({required this.isRecording});
  final bool isRecording;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.cyanColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        isRecording ? Icons.stop : Icons.mic,
        color: AppColors.white,
        size: 46,
      ),
    );
  }
}

class _UploadFromDeviceButton extends StatelessWidget {
  const _UploadFromDeviceButton({
    required this.isUploading,
    required this.onTap,
  });

  final bool isUploading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: AppColors.boarderWhiteColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppFontSize.f12),
        ),
      ),
      icon: isUploading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.cyanColor,
              ),
            )
          : const Icon(Icons.folder_open, size: 18, color: AppColors.cyanColor),
      label: Text(
        isUploading
            ? AppStrings.of(context).uploading
            : AppStrings.of(context).uploadFromDevice,
        style: AppStyle.boldSmallText.copyWith(
          fontSize: AppFontSize.f12,
          color: AppColors.textGrey,
        ),
      ),
    );
  }
}

class _CenteredLoader extends StatelessWidget {
  const _CenteredLoader({this.strokeWidth = 4.0});
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: CircularProgressIndicator(
          color: AppColors.cyanColor,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _EmptyHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          'No scans yet',
          style: AppStyle.containerSubtitle.copyWith(
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}

class _ScanTile extends StatelessWidget {
  const _ScanTile({
    required this.time,
    required this.title,
    required this.level,
    required this.color,
  });

  final String time;
  final String title;
  final String level;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationWidget.customBoxDecoration(
        context,
        borderRadius: AppFontSize.f12,
      ).copyWith(color: Theme.of(context).colorScheme.surface),
      child: ListTile(
        dense: true,
        title: Text(
          title,
          style: AppStyle.boldSmallText.copyWith(fontSize: AppFontSize.f13),
        ),
        subtitle: Text(
          time,
          style: AppStyle.containerSubtitle.copyWith(
            fontSize: AppFontSize.f10,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            level,
            style: AppStyle.containerSubtitle.copyWith(
              fontSize: AppFontSize.f10,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _DiagnosisResultCard extends StatelessWidget {
  const _DiagnosisResultCard({required this.result});
  final AiDiagnosisResponseModel result;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration:
          BoxDecorationWidget.customBoxDecoration(
            context,
            borderRadius: AppFontSize.f12,
          ).copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.06),
            border: Border.all(color: AppColors.green.withValues(alpha: 0.3)),
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecorationWidget.customBoxDecoration(context)
                .copyWith(
                  color: result.severity == "LOW"
                      ? AppColors.green.withValues(alpha: 0.3)
                      : result.severity == "MEDIUM"
                      ? AppColors.orange.withValues(alpha: 0.3)
                      : result.severity == "HIGH"
                      ? AppColors.red.withValues(alpha: 0.3)
                      : AppColors.green.withValues(alpha: 0.3),
                ),
            child: Text(
              result.severity ?? "LOW",
              style: AppStyle.containerSubtitle.copyWith(
                fontSize: AppFontSize.f10,
                color: result.severity == "LOW"
                    ? AppColors.green
                    : result.severity == "MEDIUM"
                    ? AppColors.orange
                    : result.severity == "HIGH"
                    ? AppColors.red
                    : AppColors.green,
              ),
            ),
          ),
          SizedBox(width: 10),
          const Icon(
            Icons.check_circle_outline,
            color: AppColors.green,
            size: 20,
          ),

          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.message,
                  style: AppStyle.boldSmallText.copyWith(
                    fontSize: AppFontSize.f13,
                    color: AppColors.green,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  result.resultMessage ?? 'Analysis ready',
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f12,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "The Accuraccy is : ${result.confidence}%",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DiagnosisErrorCard extends StatelessWidget {
  const _DiagnosisErrorCard({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration:
          BoxDecorationWidget.customBoxDecoration(
            context,
            borderRadius: AppFontSize.f12,
          ).copyWith(
            color: AppColors.red.withValues(alpha: 0.06),
            border: Border.all(color: AppColors.red.withValues(alpha: 0.3)),
          ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.red, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: AppStyle.containerSubtitle.copyWith(
                fontSize: AppFontSize.f12,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryErrorWidget extends StatelessWidget {
  const _HistoryErrorWidget({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            message,
            style: AppStyle.containerSubtitle.copyWith(
              color: AppColors.textGrey,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onRetry,
            child: const Text(
              'Retry',
              style: TextStyle(color: AppColors.cyanColor),
            ),
          ),
        ],
      ),
    );
  }
}
