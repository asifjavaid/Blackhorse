// lib/Utils/helpers/audio_player_helper.dart
import 'dart:developer';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class CombinedPositionData {
  final Duration position;
  final Duration duration;
  CombinedPositionData(this.position, this.duration);
}

class AudioPlayerHelper {
  AudioPlayer? _player;
  bool isInitialized = false;

  bool get isPlaying => _player?.playing ?? false;

  Stream<Duration?> get durationStream => _player?.durationStream ?? const Stream.empty();
  Stream<Duration> get positionStream => _player?.positionStream ?? const Stream.empty();
  Stream<PlayerState> get playerStateStream => _player?.playerStateStream ?? const Stream.empty();

  Future<void> reset(String url) async {
    try {
      await dispose(); // Ensure previous one is cleared
      _player = AudioPlayer();
      await _player!.setUrl(url);
      isInitialized = true;
    } catch (e) {
      log('Audio reset failed: $e');
    }
  }

  void play() {
    if (isInitialized) _player?.play();
  }

  void pause() {
    if (isInitialized) _player?.pause();
  }

  void seekTo(Duration position) {
    if (!isInitialized) return;
    // Clamp target within [0, duration]
    final d = _player!.duration;
    if (d != null) {
      if (position < Duration.zero) position = Duration.zero;
      if (position > d) position = d;
    }
    _player?.seek(position);
  }

  void jumpForward({Duration by = const Duration(seconds: 10)}) {
    if (!isInitialized) return;
    final current = _player!.position;
    final target = current + by;
    seekTo(target);
  }

  void jumpBackward({Duration by = const Duration(seconds: 10)}) {
    if (!isInitialized) return;
    final current = _player!.position;
    final target = current - by;
    seekTo(target < Duration.zero ? Duration.zero : target);
  }

  void setVolume(double value) {
    if (isInitialized) _player?.setVolume(value);
  }

  Stream<CombinedPositionData> get combinedPositionDataStream {
    return Rx.combineLatest2<Duration, Duration?, CombinedPositionData>(
      positionStream,
      durationStream,
      (position, duration) => CombinedPositionData(position, duration ?? Duration.zero),
    );
  }

  Future<void> dispose() async {
    try {
      if (_player != null) {
        await _player!.pause();
        await _player!.dispose();
        _player = null;
        isInitialized = false;
      }
    } catch (e) {
      log('Audio dispose error: $e');
    }
  }
}
