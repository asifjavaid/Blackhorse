// lib/Providers/Ekvipedia/ekvi_journeys_audio_player_provider.dart
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ekvi/Utils/helpers/audio_player_helper.dart';

class EkviJourneysAudioPlayerProvider with ChangeNotifier {
  final AudioPlayerHelper _audioHelper = AudioPlayerHelper();
  double volume = 1.0;

  bool _isLoading = false;
  bool _isDisposed = false;

  bool get isLoading => _isLoading;
  bool get isPlaying => _audioHelper.isPlaying;
  Stream<CombinedPositionData> get positionStream => _audioHelper.combinedPositionDataStream;
  Stream<PlayerState> get playerStateStream => _audioHelper.playerStateStream;

  bool _wasPlayingBeforeScrub = false;

  void _safeNotifyListeners() {
    if (!_isDisposed) {
      Future.microtask(() {
        if (!_isDisposed) notifyListeners();
      });
    }
  }

  Future<void> initialize(String url) async {
    _isLoading = true;
    _safeNotifyListeners();

    await _audioHelper.dispose();
    await _audioHelper.reset(url);
    _audioHelper.setVolume(volume);

    _isLoading = false;
    _safeNotifyListeners();
  }

  void play() => _audioHelper.play();
  void pause() => _audioHelper.pause();
  void jumpForward() => _audioHelper.jumpForward();
  void jumpBackward() => _audioHelper.jumpBackward();
  void seekTo(Duration position) => _audioHelper.seekTo(position);

  // Scrubbing helpers
  void beginScrub() {
    _wasPlayingBeforeScrub = isPlaying;
    if (_wasPlayingBeforeScrub) _audioHelper.pause();
  }

  Future<void> endScrub(Duration position) async {
    _audioHelper.seekTo(position);
    if (_wasPlayingBeforeScrub) _audioHelper.play();
  }

  void setVolume(double newVolume) {
    volume = newVolume;
    _audioHelper.setVolume(volume);
    _safeNotifyListeners();
  }

  Future<void> disposePlayer() async {
    _isLoading = true;
    _safeNotifyListeners();

    await _audioHelper.dispose();

    _isLoading = false;
    _safeNotifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _audioHelper.dispose();
    super.dispose();
  }
}
