import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerHelper {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isDisposed = false;

  Future<void> initialize(String url) async {
    _isDisposed = false;
    
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await _controller.initialize();
    
    if (_isDisposed) return;
    
    _isInitialized = true;

    await _controller.setLooping(false);

    if (kIsWeb) {
      await _controller.setVolume(0.0);
    }
    
    if (!_isDisposed) {
      unawaited(_controller.play());
    }
  }

  VideoPlayerController get controller => _controller;
  bool get isInitialized => _isInitialized;

  Future<void> play() async {
    if (_isInitialized && !_isDisposed) await _controller.play();
  }

  Future<void> pause() async {
    if (_isInitialized && !_isDisposed) await _controller.pause();
  }

  Future<void> setVolume(double volume) async {
    if (_isInitialized && !_isDisposed) await _controller.setVolume(volume);
  }

  Future<void> jumpForward(Duration offset) async {
    if (_isInitialized && !_isDisposed) {
      final newPosition = _controller.value.position + offset;
      await _controller.seekTo(newPosition);
    }
  }

  Future<void> jumpBackward(Duration offset) async {
    if (_isInitialized && !_isDisposed) {
      final newPosition = _controller.value.position - offset;
      await _controller.seekTo(newPosition);
    }
  }

  Future<void> seekTo(Duration position) async {
    if (_isInitialized && !_isDisposed) await _controller.seekTo(position);
  }

  Duration get currentPosition => _isInitialized && !_isDisposed ? _controller.value.position : Duration.zero;
  Duration get totalDuration => _isInitialized && !_isDisposed ? _controller.value.duration : Duration.zero;
  bool get isPlaying => _isInitialized && !_isDisposed ? _controller.value.isPlaying : false;

  Future<void> dispose() async {
    _isDisposed = true;
    if (_isInitialized) {
      await _controller.dispose();
      _isInitialized = false;
    }
  }
}
