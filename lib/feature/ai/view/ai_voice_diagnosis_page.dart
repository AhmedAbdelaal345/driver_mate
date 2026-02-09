import 'dart:async';
import 'dart:io';
import 'package:driver_mate/core/helper/app_notifier.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:driver_mate/core/utils/box_decoration.dart';
import 'package:driver_mate/core/utils/size.dart';
import 'package:driver_mate/feature/ai/manager/cubit/ai_diagnosis_response_cubit.dart';
import 'package:driver_mate/feature/ai/manager/state/ai_diagnosis_response_state.dart';
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
  static const int _maxSeconds = 30;
  final AudioRecorder _record = AudioRecorder();
  Timer? _timer;
  int _elapsed = 0;
  bool _isRecording = false;
  String? _filePath;
  bool _isUploading = false;

  @override
  void dispose() {
    _timer?.cancel();
    _record.dispose();
    super.dispose();
  }

  Future<bool> _requestMicPermission() async {
    return _record.hasPermission();
  }

  Future<void> _startRecording() async {
    if (!await _requestMicPermission()) {
      return;
    }
    final dir = await getTemporaryDirectory();
    final path =
        "${dir.path}/ai_voice_${DateTime.now().millisecondsSinceEpoch}.m4a";

    await _record.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: path,
    );

    if (!mounted) return;
    setState(() {
      _filePath = path;
      _isRecording = true;
      _elapsed = 0;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_elapsed >= _maxSeconds) {
        _stopRecording();
        return;
      }
      setState(() {
        _elapsed++;
      });
    });
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    await _record.stop();
    if (!mounted) return;
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _uploadRecording() async {
    final path = _filePath;
    if (path == null || !File(path).existsSync()) {
      _showSnackBar(AppConstants.noRecordingFound);
      return;
    }
    await _uploadFile(path);
  }

  Future<void> _pickAndUploadAudio() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );
      if (result == null || result.files.isEmpty) {
        return;
      }

      final picked = result.files.single;
      if (picked.path != null) {
        await _uploadFile(picked.path!);
        return;
      }

      if (picked.bytes == null) {
        _showSnackBar(AppConstants.pickAudioFailed);
        return;
      }

      final dir = await getTemporaryDirectory();
      final tempPath = "${dir.path}/${picked.name}";
      final file = File(tempPath);
      await file.writeAsBytes(picked.bytes!, flush: true);
      await _uploadFile(tempPath);
    } catch (_) {
      _showSnackBar(AppConstants.pickAudioFailed);
    }
  }

  Future<void> _uploadFile(String path) async {
    if (!mounted) return;
    setState(() {
      _isUploading = true;
    });

    context.read<AiDiagnosisCubit>().sendAudio(path);

    if (!mounted) return;
    setState(() {
      _isUploading = false;
    });
    // final message = response.
    //     ? AppConstants.uploadSuccess
    //     : AppConstants.uploadFailed;

    // _showSnackBar(message);
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppConstants.chooseUploadSource,
                  style: AppStyle.boldSmallText.copyWith(
                    fontSize: AppFontSize.f13,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.mic, color: AppColors.cyanColor),
                  title: Text(AppConstants.uploadRecording),
                  onTap: () {
                    Navigator.pop(context);
                    _uploadRecording();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.folder_open,
                    color: AppColors.cyanColor,
                  ),
                  title: Text(AppConstants.uploadFromDevice),
                  onTap: () {
                    Navigator.pop(context);
                    _pickAndUploadAudio();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeLabel = "${_elapsed.toString().padLeft(2, "0")}s";

    return BlocListener<AiDiagnosisCubit, AiDiagnosisState>(
      listener: (context, state) {
        if (state is AiLoading) {
          setState(() => _isUploading = true);
        }

        if (state is AiSuccess) {
          setState(() => _isUploading = false);

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Diagnosis Result"),
              content: Text(state.result),
            ),
          );
        }

        if (state is AiError) {
          setState(() => _isUploading = false);

          AppNotifier.show(context, state.message, type: NotifierType.error);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            AppConstants.aiVoiceDiagnosis,
            style: AppStyle.appBarTitle,
          ),
          leading: const LeadingIcon(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width(context) * 0.05,
              vertical: SizeConfig.height(context) * 0.015,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration:
                      BoxDecorationWidget.customBoxDecoration(
                        borderRadius: AppFontSize.f12,
                      ).copyWith(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.veryDarkBlue, AppColors.cyanColor],
                        ),
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.recordCarSound,
                        style: AppStyle.boldSmallText.copyWith(
                          color: AppColors.white,
                          fontSize: AppFontSize.f13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        AppConstants.recordHint,
                        style: AppStyle.containerSubtitle.copyWith(
                          color: AppColors.white.withValues(alpha: 0.9),
                          fontSize: AppFontSize.f11,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.03),
                Center(
                  child: GestureDetector(
                    onTap: _isRecording ? _stopRecording : _startRecording,
                    child: Container(
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
                        _isRecording ? Icons.stop : Icons.mic,
                        color: AppColors.white,
                        size: 46,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    _isRecording
                        ? AppConstants.recordStop
                        : AppConstants.tapToStart,
                    style: AppStyle.containerSubtitle.copyWith(
                      color: AppColors.textGrey,
                      fontSize: AppFontSize.f12,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Center(
                  child: Text(
                    _isRecording ? timeLabel : AppConstants.max30Seconds,
                    style: AppStyle.containerSubtitle.copyWith(
                      color: AppColors.iconGrey,
                      fontSize: AppFontSize.f10,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.height(context) * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isUploading ? null : _showUploadOptions,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: AppColors.boarderWhiteColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppFontSize.f12,
                            ),
                          ),
                        ),
                        icon: Icon(
                          Icons.file_upload_outlined,
                          size: 18,
                          color: AppColors.cyanColor,
                        ),
                        label: Text(
                          _isUploading
                              ? AppConstants.uploading
                              : AppConstants.uploadAudio,
                          style: AppStyle.boldSmallText.copyWith(
                            fontSize: AppFontSize.f12,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: AppColors.boarderWhiteColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppFontSize.f12,
                            ),
                          ),
                        ),
                        icon: Icon(
                          Icons.info_outline,
                          size: 18,
                          color: AppColors.cyanColor,
                        ),
                        label: Text(
                          AppConstants.recordingTips,
                          style: AppStyle.boldSmallText.copyWith(
                            fontSize: AppFontSize.f12,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.height(context) * 0.02),
                Text(
                  AppConstants.recentScans,
                  style: AppStyle.containerSubtitle.copyWith(
                    color: AppColors.iconGrey,
                    fontSize: AppFontSize.f11,
                  ),
                ),
                const SizedBox(height: 8),
                _ScanTile(
                  time: AppConstants.today,
                  title: AppConstants.engineBeltNoise,
                  level: AppConstants.medium,
                  color: AppColors.orange,
                ),
                const SizedBox(height: 10),
                _ScanTile(
                  time: AppConstants.yesterday,
                  title: AppConstants.brakeSqueal,
                  level: AppConstants.low,
                  color: AppColors.green,
                ),
                const SizedBox(height: 10),
                _ScanTile(
                  time: AppConstants.jan20,
                  title: AppConstants.fanRattle,
                  level: AppConstants.high,
                  color: AppColors.red,
                ),
              ],
            ),
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
        borderRadius: AppFontSize.f12,
      ).copyWith(color: AppColors.white),
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
            color: AppColors.iconGrey,
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
