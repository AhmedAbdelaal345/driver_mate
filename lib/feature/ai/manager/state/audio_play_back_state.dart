enum AudioPlaybackStatus { idle, loading, playing, paused, error }

class AudioPlaybackState {
  // currentId tracks WHICH history item is associated with the player.
  // Only one item can be playing/loading/paused at a time — this is
  // the single source of truth that enforces "one audio at a time".
  final String? currentId;
  final AudioPlaybackStatus status;
  final String? errorMessage;

  const AudioPlaybackState({
    this.currentId,
    this.status = AudioPlaybackStatus.idle,
    this.errorMessage,
  });

  AudioPlaybackState copyWith({
    String? currentId,
    AudioPlaybackStatus? status,
    String? errorMessage,
  }) {
    return AudioPlaybackState(
      currentId: currentId ?? this.currentId,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}