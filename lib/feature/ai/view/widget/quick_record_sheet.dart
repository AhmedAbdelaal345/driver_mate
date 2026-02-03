import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:driver_mate/core/network/api_constants.dart';
import 'package:driver_mate/core/network/api_helper.dart';
import 'package:driver_mate/core/utils/app_colors.dart';
import 'package:driver_mate/core/utils/app_constants.dart';
import 'package:driver_mate/core/utils/app_font_size.dart';
import 'package:driver_mate/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class QuickRecordSheet extends StatefulWidget {
  const QuickRecordSheet({super.key});

  @override
  State<QuickRecordSheet> createState() => _QuickRecordSheetState();
}

class _QuickRecordSheetState extends State<QuickRecordSheet> {
  static const int _maxSeconds = 30;
  static const bool _useMockResponse = true;

  final AudioRecorder _recorder = AudioRecorder();
  Timer? _timer;
  int _elapsed = 0;
  bool _isRecording = false;
  bool _isAnalyzing = false;
  String? _filePath;
  _AnalysisResult? _result;

  @override
  void dispose() {
    _timer?.cancel();
    _recorder.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();
      await _analyzeRecording();
      return;
    }

    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      _showSnack(AppConstants.micPermissionDenied);
      return;
    }

    final dir = await getTemporaryDirectory();
    final path =
        "${dir.path}/quick_record_${DateTime.now().millisecondsSinceEpoch}.m4a";

    await _recorder.start(
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
      _result = null;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_elapsed >= _maxSeconds) {
        _stopRecording();
        _analyzeRecording();
        return;
      }
      setState(() {
        _elapsed++;
      });
    });
  }

  Future<void> _stopRecording() async {
    _timer?.cancel();
    await _recorder.stop();
    if (!mounted) return;
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _analyzeRecording() async {
    if (_filePath == null) {
      return;
    }
    setState(() => _isAnalyzing = true);

    if (_useMockResponse) {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      setState(() {
        _isAnalyzing = false;
        _result = _mockResult();
      });
      return;
    }

    try {
      final data = {
        "file": await MultipartFile.fromFile(
          _filePath!,
          filename: "recording.m4a",
        ),
      };
      final response = await ApiHelper().postRequest(
        endpoint: ApiConstants.audioDiagnosisEndpoint,
        data: data,
        isForm: true,
        isAuthorized: true,
      );

      if (!mounted) return;
      setState(() {
        _isAnalyzing = false;
        _result = _AnalysisResult(
          title: response.status
              ? AppConstants.engineBeltNoise
              : AppConstants.uploadFailed,
          subtitle: response.message,
          level: response.status ? AppConstants.medium : AppConstants.high,
          levelColor: response.status ? AppColors.orange : AppColors.red,
        );
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isAnalyzing = false;
        _result = _AnalysisResult(
          title: AppConstants.uploadFailed,
          subtitle: AppConstants.tryAgain,
          level: AppConstants.high,
          levelColor: AppColors.red,
        );
      });
    }
  }

  _AnalysisResult _mockResult() {
    final options = [
      _AnalysisResult(
        title: AppConstants.engineBeltNoise,
        subtitle: AppConstants.mockEngineBelt,
        level: AppConstants.medium,
        levelColor: AppColors.orange,
      ),
      _AnalysisResult(
        title: AppConstants.brakeSqueal,
        subtitle: AppConstants.mockBrakeSqueal,
        level: AppConstants.low,
        levelColor: AppColors.green,
      ),
      _AnalysisResult(
        title: AppConstants.fanRattle,
        subtitle: AppConstants.mockFanRattle,
        level: AppConstants.high,
        levelColor: AppColors.red,
      ),
    ];
    return options[Random().nextInt(options.length)];
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeLabel = "${_elapsed.toString().padLeft(2, "0")}s";

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppConstants.aiVoiceDiagnosis,
              style: AppStyle.titleForContainer,
            ),
            const SizedBox(height: 8),
            Text(
              AppConstants.recordHint,
              style: AppStyle.containerSubtitle.copyWith(
                fontSize: AppFontSize.f11,
                color: AppColors.iconGrey,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: GestureDetector(
                onTap: _isAnalyzing ? null : _toggleRecording,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: _isRecording ? AppColors.red : AppColors.cyanColor,
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
                    size: 34,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                _isRecording
                    ? "${AppConstants.recordStop} • $timeLabel"
                    : AppConstants.recordStart,
                style: AppStyle.containerSubtitle.copyWith(
                  fontSize: AppFontSize.f11,
                  color: AppColors.textGrey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_isAnalyzing)
              Center(
                child: Text(
                  AppConstants.analyzingSound,
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f11,
                    color: AppColors.cyanColor,
                  ),
                ),
              ),
            if (_result != null) _ResultCard(result: _result!),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _isRecording ? null : () => Navigator.pop(context),
              child: Text(AppConstants.close),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.result});

  final _AnalysisResult result;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppFontSize.f12),
        border: Border.all(color: AppColors.boarderWhiteColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  result.title,
                  style: AppStyle.boldSmallText.copyWith(
                    fontSize: AppFontSize.f12,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: result.levelColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  result.level,
                  style: AppStyle.containerSubtitle.copyWith(
                    fontSize: AppFontSize.f10,
                    color: result.levelColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            result.subtitle,
            style: AppStyle.containerSubtitle.copyWith(
              fontSize: AppFontSize.f10,
              color: AppColors.iconGrey,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalysisResult {
  const _AnalysisResult({
    required this.title,
    required this.subtitle,
    required this.level,
    required this.levelColor,
  });

  final String title;
  final String subtitle;
  final String level;
  final Color levelColor;
}
