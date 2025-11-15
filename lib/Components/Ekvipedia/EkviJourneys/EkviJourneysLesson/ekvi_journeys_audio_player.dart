// lib/Components/Ekvipedia/EkviJourneys/ekvi_journeys_audio_player.dart
import 'dart:math' as math;

import 'package:ekvi/Models/EkviJourneys/current_course_lesson.dart';
import 'package:ekvi/Models/EkviJourneys/lesson_structure.dart';
import 'package:ekvi/Providers/Ekvipedia/ekvi_journeys_audio_player_provider.dart';
import 'package:ekvi/Utils/constants/app_colors.dart';
import 'package:ekvi/Utils/constants/app_constant.dart';
import 'package:ekvi/Utils/helpers/audio_player_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EkviJourneysAudioPlayer extends StatefulWidget {
  final LessonStructure? lesson;
  final CurrentCourseLesson? currentLesson;

  const EkviJourneysAudioPlayer({
    super.key,
    this.lesson,
    this.currentLesson,
  });

  @override
  State<EkviJourneysAudioPlayer> createState() => _EkviJourneysAudioPlayerState();
}

class _EkviJourneysAudioPlayerState extends State<EkviJourneysAudioPlayer> {
  late EkviJourneysAudioPlayerProvider _audioProvider;

  bool _isScrubbing = false;
  double _scrubValueMs = 0;

  @override
  void initState() {
    super.initState();

    final url = widget.lesson?.mediaUrl ?? widget.currentLesson?.mediaUrl ?? '';
    _audioProvider = context.read<EkviJourneysAudioPlayerProvider>();

    if (url.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        _audioProvider.disposePlayer();
        await _audioProvider.initialize(url);
      });
    }
  }

  @override
  void dispose() {
    _audioProvider.disposePlayer();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EkviJourneysAudioPlayerProvider>();

    return StreamBuilder<CombinedPositionData>(
      stream: provider.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data?.position ?? Duration.zero;
        final duration = snapshot.data?.duration ?? Duration.zero;

        // work entirely in doubles (milliseconds) to avoid num/double clamp issues
        double maxMs = duration.inMilliseconds.toDouble();
        if (maxMs <= 0) maxMs = 1; // avoid NaN/infinite slider issues

        final positionMs = position.inMilliseconds.toDouble();
        final currentMs = _isScrubbing ? _scrubValueMs : math.min(math.max(positionMs, 0.0), maxMs);

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Slider(
                  value: currentMs,
                  max: maxMs, // already >= 1
                  onChangeStart: (_) {
                    _isScrubbing = true;
                    _scrubValueMs = currentMs;
                    provider.beginScrub();
                    setState(() {});
                  },
                  onChanged: (v) {
                    _scrubValueMs = math.min(math.max(v, 0.0), maxMs);
                    setState(() {});
                  },
                  onChangeEnd: (v) async {
                    _isScrubbing = false;
                    _scrubValueMs = math.min(math.max(v, 0.0), maxMs);
                    await provider.endScrub(
                      Duration(milliseconds: _scrubValueMs.toInt()),
                    );
                    setState(() {});
                  },
                  activeColor: AppColors.primaryColor600,
                  inactiveColor: AppColors.primaryColor500,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDuration(
                            Duration(milliseconds: currentMs.toInt()))),
                        Text(
                          "-${_formatDuration(duration - Duration(milliseconds: currentMs.toInt()))}",
                        ),
                      ],
                    ),
                  ),
              ],
            ),
                  
            // Play controls
              provider.isLoading
                  ? const Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  : StreamBuilder<PlayerState>(
                      stream: provider.playerStateStream,
                      builder: (context, snapshot) {
                        final isPlaying = snapshot.data?.playing ?? false;
                  
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: provider.jumpBackward,
                              child: SvgPicture.asset(
                                '${AppConstant.assetIcons}secBack.svg',
                                width: 40,
                                height: 40,
                                color: AppColors.actionColor600,
                              ),
                            ),
                            const SizedBox(width: 60),
                            GestureDetector(
                              onTap: () => isPlaying
                                  ? provider.pause()
                                  : provider.play(),
                              child: Icon(
                                isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: AppColors.actionColor600,
                                size: 70,
                              ),
                            ),
                            const SizedBox(width: 60),
                            GestureDetector(
                              onTap: provider.jumpForward,
                              child: SvgPicture.asset(
                                '${AppConstant.assetIcons}secForward.svg',
                                width: 40,
                                height: 40,
                                color: AppColors.actionColor600,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Padding(
                padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 22.h),
                child: Row(
                  children: [
                    SvgPicture.asset(
                        '${AppConstant.assetIcons}volume1.svg'),
                    Expanded(
                      child: Slider(
                        value: provider.volume,
                        activeColor: AppColors.primaryColor600,
                        inactiveColor: AppColors.primaryColor500,
                        onChanged: provider.setVolume,
                        min: 0.0,
                        max: 1.0,
                      ),
                    ),
                    SvgPicture.asset(
                        '${AppConstant.assetIcons}volume2.svg'),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
