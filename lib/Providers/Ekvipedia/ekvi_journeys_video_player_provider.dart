import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:ekvi/Utils/helpers/video_player_helper.dart';
import 'package:video_player/video_player.dart';

class EkviJourneysVideoPlayerProvider with ChangeNotifier {
  final VideoPlayerHelper _videoHelper = VideoPlayerHelper();

  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  bool isPlaying = false;
  bool showControls = true;
  bool isVideoReady = false;
  bool _isDisposed = false;
  bool _unmutedAfterAutoplay = false; // web: unmute on first user action

  Timer? _positionTimer;
  Timer? _hideControlsTimer;

  VideoPlayerController? get controller =>
      _videoHelper.isInitialized ? _videoHelper.controller : null;

  void _resetState() {
    _isDisposed = false;
    position = Duration.zero;
    duration = Duration.zero;
    isPlaying = false;
    showControls = true;
    isVideoReady = false;
    _unmutedAfterAutoplay = false;
    _positionTimer?.cancel();
    _hideControlsTimer?.cancel();
  }

  Future<void> initialize(String url) async {
    if (url.isEmpty) return;

    try {
      // Reset all state for new initialization
      _resetState();
      await _videoHelper.initialize(url);

      // Check if disposed during initialization
      if (_isDisposed) return;

      // Start progress tracking
      _startPositionTracking();

      // Wait a moment for auto-play to start, then check the playing state
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Check again if disposed during delay
      if (_isDisposed) return;
      
      isPlaying = _videoHelper.isPlaying;
      isVideoReady = true;
      notifyListeners();

      if (isPlaying) _startHideControlsTimer();
    } catch (e) {
      isVideoReady = false;
      notifyListeners();
    }
  }

  void _startPositionTracking() {
    _positionTimer?.cancel();
    _positionTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (_isDisposed) return;
      if (_videoHelper.isInitialized) {
        position = _videoHelper.currentPosition;
        duration = _videoHelper.totalDuration;
        final playing = _videoHelper.isPlaying;
        if (playing != isPlaying) {
          isPlaying = playing;
          // when playback starts, (re)arm auto-hide
          if (isPlaying && showControls) _startHideControlsTimer();
        }
        notifyListeners();
      }
    });
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (_isDisposed) return;
      if (isPlaying && showControls) {
        showControls = false;
        notifyListeners();
      }
    });
  }

  void toggleControlsVisibility() {
    if (_isDisposed) return;
    showControls = !showControls;
    notifyListeners();
    if (showControls && isPlaying) _startHideControlsTimer();
  }

  Future<void> _maybeUnmuteAfterAutoplay() async {
    // On web we started muted to allow autoplay. Unmute on the first explicit user play.
    if (kIsWeb && !_unmutedAfterAutoplay) {
      await _videoHelper.setVolume(1.0);
      _unmutedAfterAutoplay = true;
    }
  }

  Future<void> playPause() async {
    if (_isDisposed) return;
    if (isPlaying) {
      await _videoHelper.pause();
      isPlaying = false;
      showControls = true; // keep controls visible when paused
      _hideControlsTimer?.cancel();
    } else {
      await _maybeUnmuteAfterAutoplay();
      await _videoHelper.play();
      isPlaying = true;
      // show briefly then auto-hide
      showControls = true;
      _startHideControlsTimer();
    }
    notifyListeners();
  }

  void seekTo(Duration position) {
    if (_isDisposed) return;
    _videoHelper.seekTo(position);
  }
  
  void jumpForward() {
    if (_isDisposed) return;
    _videoHelper.jumpForward(const Duration(seconds: 10));
  }
  
  void jumpBackward() {
    if (_isDisposed) return;
    _videoHelper.jumpBackward(const Duration(seconds: 10));
  }

  void disposePlayer() {
    _isDisposed = true;
    _positionTimer?.cancel();
    _hideControlsTimer?.cancel();
    _videoHelper.dispose();
    isVideoReady = false;
    isPlaying = false;
    _unmutedAfterAutoplay = false;
  }
}
