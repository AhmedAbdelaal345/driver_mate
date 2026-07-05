import 'package:audioplayers/audioplayers.dart';
import 'package:driver_mate/feature/ai/manager/state/audio_play_back_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages playback for diagnosis history audio clips.
/// A single AudioPlayer instance is reused — this is what guarantees
/// only one clip plays at a time across the whole history list.
class AudioPlaybackCubit extends Cubit<AudioPlaybackState> {
  AudioPlaybackCubit() : super(const AudioPlaybackState()) {
    _player.onPlayerStateChanged.listen(_handleStateChanged);
    _player.onPlayerComplete.listen((_) => emit(const AudioPlaybackState()));
  }

  final AudioPlayer _player = AudioPlayer();

  // ── Play / resume a clip identified by [id] ──────────────────────────────
  Future<void> playAudio(String id, String url) async {
    try {
      // Tapping the same paused item → resume instead of restarting
      if (state.currentId == id && state.status == AudioPlaybackStatus.paused) {
        await _player.resume();
        return;
      }

      // Switching to a different item → stop the previous one first
      if (state.currentId != null && state.currentId != id) {
        await _player.stop();
      }

      emit(AudioPlaybackState(currentId: id, status: AudioPlaybackStatus.loading));
      await _player.play(UrlSource(url));
    } catch (e) {
      emit(AudioPlaybackState(
        currentId: id,
        status: AudioPlaybackStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> pauseAudio() => _player.pause();

  Future<void> stopAudio() async {
    await _player.stop();
    emit(const AudioPlaybackState());
  }

  void _handleStateChanged(PlayerState playerState) {
    if (state.currentId == null) return;
    switch (playerState) {
      case PlayerState.playing:
        emit(state.copyWith(status: AudioPlaybackStatus.playing));
        break;
      case PlayerState.paused:
        emit(state.copyWith(status: AudioPlaybackStatus.paused));
        break;
      case PlayerState.stopped:
      case PlayerState.completed:
        emit(const AudioPlaybackState());
        break;
      default:
        break;
    }
  }

  @override
  Future<void> close() {
    _player.dispose();
    return super.close();
  }
}